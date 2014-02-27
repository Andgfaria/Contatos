//
//  ViewControllerCriacaoContatoTabela.m
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerTabela.h"
#import "ViewControllerCriacaoContato.h"
#import "FabricaContatos.h"
#import "Contato.h"
#import "ViewControllerDetalhesContato.h"
#import "ListaContatosDAO.h"
#import "ViewControllerEdicaoContato.h"


@interface ViewControllerTabela ()

@end

@implementation ViewControllerTabela



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[self navigationController] setTitle:@"Contatos"];
        [self inicializarMutableArrays];
        ListaContatosDAO *listaDAO = [[ListaContatosDAO alloc] init];
        NSArray *array;
        for (int i = 0; i < 26; i++) {
            array = [listaDAO retornarArrayDaLetra:(char)(i+65)];
            if (array != nil) {
                listaContatos[i] = [[NSMutableArray alloc] initWithArray:array];
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(ativarViewCriarContato:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:nil target:self action:@selector(ativarEdicao:)];
    self.navigationItem.title = @"Contatos";
   // header = [[[NSBundle mainBundle] loadNibNamed:@"Header" owner:self options:nil] objectAtIndex:0];
   // self.tableView.tableHeaderView = header;

      // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listaContatos[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celulaContato"];
    // Configure the cell...
    NSString *nome = [[listaContatos[indexPath.section] objectAtIndex:[indexPath row]] nome];
    NSString *sobrenome = [[listaContatos[indexPath.section] objectAtIndex:[indexPath row]] sobrenome];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@",nome,sobrenome]];
    [[cell imageView] setImage:[self imageWithImage:[[listaContatos[indexPath.section] objectAtIndex:indexPath.row] foto] scaledToSize:CGSizeMake(36, 36)]];

    return cell;
}
         
- (IBAction)ativarEdicao:(id)sender {
    if ([self isEditing]) {
        [self setEditing:NO];
        self.navigationItem.leftBarButtonItem.title = @"Editar";
        
    }
    else{
        [self setEditing:YES];
        self.navigationItem.leftBarButtonItem.title = @"OK";
    }
}

- (IBAction)ativarViewCriarContato:(id)sender {
    ViewControllerCriacaoContato *view = [[ViewControllerCriacaoContato alloc] initWithNibName:@"CriacaoContato" bundle:nil];
    [[self navigationController] pushViewController:view animated:YES];
   // [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:view animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Returns section title based on physical state: [solid, liquid, gas, artificial]
    char c = 65 + section;
    NSString *titulo = [NSString stringWithFormat:@"%c",c];
    return titulo; 
}

-(void) inicializarMutableArrays {
    for (int i = 0; i < 26; i++) {
        listaContatos[i] = nil;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Deletar";
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ListaContatosDAO *listaDAO = [[ListaContatosDAO alloc] init];
        [listaContatos[[indexPath section]] removeObjectAtIndex:[indexPath row]];
        NSArray *array = [[NSArray alloc] initWithObjects:indexPath, nil];
        [(UITableView *)([self view]) deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        [listaDAO persistirListaContatos:listaContatos[[indexPath section]] ComLetra:(char)(indexPath.section + 65)];
    }
}

-(void) viewDidAppear:(BOOL)animated {
    NSData *contatoArmazenado = [[NSUserDefaults standardUserDefaults] objectForKey:@"novoContato"];
    NSData *contatoModificado = [[NSUserDefaults standardUserDefaults] objectForKey:@"contatoModificado"];
    if (contatoArmazenado != nil) {
        Contato *novo = [NSKeyedUnarchiver unarchiveObjectWithData:contatoArmazenado];
        char c = [[novo nome] characterAtIndex:0];
        NSInteger i = (int)c - 65;
        if (listaContatos[i] == nil) {
            listaContatos[i] = [[NSMutableArray alloc] init];
        }
        NSUInteger indice =  [self acharIndiceApropriado:novo noArray:listaContatos[(int)c-65]];
        [listaContatos[(int)c - 65] insertObject:novo atIndex:indice];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indice inSection:i];
        NSArray *array = [[NSArray alloc] initWithObjects:indexPath, nil];
        [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
      //  [(UITableView *)([self view]) insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"novoContato"];
        ListaContatosDAO *listaDAO = [[ListaContatosDAO alloc] init];
        [listaDAO persistirListaContatos:listaContatos[(int)c-65] ComLetra:[novo.nome characterAtIndex:0]];
    }
    if (contatoModificado != nil) {
        Contato *modificado = [NSKeyedUnarchiver unarchiveObjectWithData:contatoModificado];
        char c = [[modificado nome] characterAtIndex:0];
        NSInteger i = (int)c - 65;
        NSUInteger indice =  [self acharIndiceApropriado:modificado noArray:listaContatos[(int)c-65]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indice inSection:i];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@",modificado.nome,modificado.sobrenome]];
        [self.tableView reloadData];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"contatoModificado"];
    }
}



-(NSUInteger) acharIndiceApropriado:(Contato *)contato noArray:(NSMutableArray *)array {
    NSUInteger indice = [array indexOfObject:contato inSortedRange:NSMakeRange(0,[array count]) options:NSBinarySearchingInsertionIndex usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *nome1 = [[NSString alloc] initWithString:(Contato *)[obj1 nome]];
        NSString *nome2 = [[NSString alloc] initWithString:(Contato *)[obj2 nome]];
        return [nome1 compare:nome2 options:NSLiteralSearch];
    }];
    return indice;
}


-(NSComparisonResult) compararString:(id)string1 com:(id)string2 {
    return [string1 compare:string2 options:NSLiteralSearch];
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    ViewControllerDetalhesContato *viewContato = [[ViewControllerDetalhesContato alloc] initWithNibName:@"ViewDetalhesContato" bundle:nil contato:[listaContatos[indexPath.section] objectAtIndex:indexPath.row]];
    [[self navigationController] pushViewController:viewContato animated:YES];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewControllerCriacaoContato].
    // Pass the selected object to the new view controller.
}

 */


@end
