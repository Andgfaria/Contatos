//
//  ViewControllerEdicaoContato.m
//  Contato
//
//  Created by André Gimenez Faria on 21/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerEdicaoContato.h"

@interface ViewControllerEdicaoContato ()

@end

@implementation ViewControllerEdicaoContato

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contato:(Contato *)c {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        contato = c;
    }
    return self;
}

- (void) atualizarContato {
    NSString *nome = [[NSString alloc] initWithString:[_txtNome text]];
    NSString *sobrenome = [[NSString alloc] initWithString:[_txtSobrenome text]];
    NSNumberFormatter *formatador = [[NSNumberFormatter alloc] init];
    [formatador setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *telefone = [formatador numberFromString:[_txtTelefone text]];
    NSNumber *celular = [formatador numberFromString:[_txtCelular text]];
    NSString *endereco = [[NSString alloc] initWithString:[_txtEndereco text]];
    contato.nome = nome;
    contato.sobrenome = sobrenome;
    contato.telefone = telefone;
    contato.celular = celular;
    contato.endereco = endereco;
    
    NSData *contatoModificado = [NSKeyedArchiver archivedDataWithRootObject:contato];
    [[NSUserDefaults standardUserDefaults] setObject:contatoModificado forKey:@"contatoModificado"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar Alterações" style:UIBarButtonItemStylePlain target:self action:@selector(atualizarContato)];
    [_txtNome setText:[contato nome]];
    [_txtSobrenome setText:[contato sobrenome]];
    [_txtTelefone setText:[[contato telefone] stringValue]];
    [_txtCelular setText:[[contato celular] stringValue]];
    [_txtEndereco setText:[contato endereco]];
    if ([contato foto] != nil) {
        [_btnAlterarFoto setHidden:NO];
    }
    else [_btnAdicionarFoto setHidden:NO];
	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (popup == opcoesAlterarFoto) {
        switch (buttonIndex) {
            case 0:
                contato.foto = nil;
                [_btnAdicionarFoto setHidden:NO];
                [_btnAlterarFoto setHidden:YES];
                break;
            case 1:
                [self tirarFoto];
                break;
            case 2:
                [self selecionarFotoExistente];
                break;
            default:
                break;
        }
    }
    else {
        switch (buttonIndex) {
            case 1:
                [self tirarFoto];
                [_btnAdicionarFoto setHidden:YES];
                [_btnAlterarFoto setHidden:NO];
                break;
            case 2:
                [self selecionarFotoExistente];
                [_btnAdicionarFoto setHidden:YES];
                [_btnAlterarFoto setHidden:NO];
            default:
                break;
        }
    }
}

- (IBAction)alterarFoto:(id)sender {
    opcoesAlterarFoto = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:@"Remover Foto" otherButtonTitles:@"Tirar Foto",@"Escolher Foto Existente", nil];
    [opcoesAlterarFoto showInView:self.view];
}

- (IBAction)adicionarFoto:(id)sender {
   opcoesAdicionarFoto = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto",@"Escolher Foto Existente", nil];
    [opcoesAdicionarFoto showInView:self.view];
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
    contato.foto = [self imageWithImage:imagemEscolhida scaledToSize:CGSizeMake(128, 128)];
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
