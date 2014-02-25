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
    Contato *novo = [[Contato alloc] initWithNome:nome eSobrenome:sobrenome eTelefone:telefone eCelular:celular eEndereco:endereco];
    NSData *cadastro = [NSKeyedArchiver archivedDataWithRootObject:novo];
    [[NSUserDefaults standardUserDefaults] setObject:cadastro forKey:@"novoContato"];
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
