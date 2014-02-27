//
//  ViewControllerCriacaoContato.m
//  Contato
//
//  Created by André Gimenez Faria on 20/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerCriacaoContato.h"
#import "Contato.h"

@interface ViewControllerCriacaoContato ()

@end

@implementation ViewControllerCriacaoContato

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem.title = @"Contatos";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Criar" style:nil target:self action:@selector(criarContato:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc ] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title = @"Novo Contato";
    

    
    [_txtNome addTarget:self action:@selector(mudarEstadoBotao) forControlEvents:UIControlEventEditingChanged];
    [_txtSobrenome addTarget:self action:@selector(mudarEstadoBotao) forControlEvents:UIControlEventEditingChanged];
    [_txtTelefone addTarget:self action:@selector(mudarEstadoBotao) forControlEvents:UIControlEventEditingChanged];
    [_txtCelular addTarget:self action:@selector(mudarEstadoBotao) forControlEvents:UIControlEventEditingChanged];
    [_txtEndereco addTarget:self action:@selector(mudarEstadoBotao) forControlEvents:UIControlEventEditingChanged];
	// Do any additional setup after loading the view.
}

-(void) mudarEstadoBotao {
    BOOL nomePreenchido = ![_txtNome.text isEqualToString:@""];
    BOOL sobrenomePreenchido = ![_txtSobrenome.text isEqualToString:@""];
    BOOL telefonePreenchido = ![_txtTelefone.text isEqualToString:@""];
    BOOL celularPreenchido = ![_txtCelular.text isEqualToString:@""];
    BOOL enderecoPreenchido = ![_txtEndereco.text isEqualToString:@""];
    BOOL entradaOK = nomePreenchido && sobrenomePreenchido && telefonePreenchido && celularPreenchido && enderecoPreenchido;
    if (entradaOK) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textViewShouldReturn:(UITextView *)textView {
    [textView resignFirstResponder];
    return YES;
}

- (IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)criarContato:(id)sender {
    [_txtNome resignFirstResponder];
    [_txtSobrenome resignFirstResponder];
    [_txtTelefone resignFirstResponder];
    [_txtCelular resignFirstResponder];
    [_txtEndereco resignFirstResponder];
    NSString *nome = [[NSString alloc] initWithString:[_txtNome text]];
    NSString *sobrenome = [[NSString alloc] initWithString:[_txtSobrenome text]];
    NSNumberFormatter *formatador = [[NSNumberFormatter alloc] init];
    [formatador setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *telefone = [formatador numberFromString:[_txtTelefone text]];
    NSNumber *celular = [formatador numberFromString:[_txtCelular text]];
    NSString *endereco = [[NSString alloc] initWithString:[_txtEndereco text]];
    Contato *novo = [[Contato alloc] initWithNome:nome eSobrenome:sobrenome eTelefone:telefone eCelular:celular eEndereco:endereco eFoto:_imagemContato.image];
    NSData *cadastro = [NSKeyedArchiver archivedDataWithRootObject:novo];
    [[NSUserDefaults standardUserDefaults] setObject:cadastro forKey:@"novoContato"];
    [[self navigationController] popViewControllerAnimated:YES];
}
- (IBAction)foto:(id)sender {
    UIActionSheet *novo = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto",@"Escolher Foto Existente", nil];
    [novo showInView:self.view];
    }

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self tirarFoto];
            break;
        case 1:
            [self selecionarFotoExistente];
            break;
        default:
            break;
    }
}

-(void) tirarFoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Câmera Não Disponível" message:@"Este dispositivo não possui uma câmera para tirar foto." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
    }
}

-(void) selecionarFotoExistente {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imagePicker animated:YES completion:nil];
   
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagemEscolhida = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *imagemRedimensionada = [self imageWithImage:imagemEscolhida scaledToSize:CGSizeMake(128, 128)];
    [_imagemContato setImage:imagemRedimensionada];
    _imagemContato.contentMode = UIViewContentModeScaleAspectFit;
    [_imagemContato setHidden:NO];
    [_btnTirarFoto setHidden:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
