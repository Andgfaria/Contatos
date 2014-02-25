//
//  ViewControllerTabela.m
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerTabela.h"
#import "FabricaContatos.h"
#import "Contato.h"

@interface ViewControllerTabela ()

@end

@implementation ViewControllerTabela

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        listaContatos = [[NSMutableArray alloc] init];
        FabricaContatos *fabricaContatos = [FabricaContatos sharedInstance];
        for (int i = 0; i < 5; i++) {
            Contato *contato = [fabricaContatos criarContato];
            [listaContatos addObject:contato];
            char c = [[contato nome] characterAtIndex:0];
            ocorrencias[(int)c - 65]++;
         //   NSLog(@"%@",(int)[ocorrenciasPorLetra objectForKey:@"A"] + 1);
        }
        for (int i = 0; i < 26; i++) {
            NSLog(@"ocorrencias[%d] = %d",i,ocorrencias[i]);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    return [listaContatos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celulaContato"];
    // Configure the cell...
    NSString *nome = [[listaContatos objectAtIndex:[indexPath row]] nome];
    NSString *sobrenome = [[listaContatos objectAtIndex:[indexPath row]] sobrenome];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@",nome,sobrenome]];

    return cell;
}
         


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Returns section title based on physical state: [solid, liquid, gas, artificial]
    char c = 65 + section;
    NSString *titulo = [NSString stringWithFormat:@"%c",c];
    return titulo;
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
