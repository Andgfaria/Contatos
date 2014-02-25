//
//  ViewControllerDetalhesContato.m
//  Contato
//
//  Created by André Gimenez Faria on 21/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewControllerDetalhesContato.h"
#import "ViewControllerEdicaoContato.h"

@interface ViewControllerDetalhesContato ()

@end

@implementation ViewControllerDetalhesContato

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contato:(Contato *)c {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        contato = c;
    }
    return self;
}

-(void) mostrarEdicaoContato {
    ViewControllerEdicaoContato *edicaoContato = [[ViewControllerEdicaoContato alloc] initWithNibName:@"ViewEdicaoContato" bundle:nil contato:contato];
 //   [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:edicaoContato animated:YES completion:nil];
    [self.navigationController pushViewController:edicaoContato animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = contato.nome;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Alterar Dados" style:UIBarButtonItemStylePlain target:self action:@selector(mostrarEdicaoContato)];
    [self exibirDadosContato];
    	// Do any additional setup after loading the view.
}

-(void)exibirDadosContato {
    [_txtNomeSobrenome setText:[NSString stringWithFormat:@"%@ %@",contato.nome,contato.sobrenome]];
    [_txtTelefone setText:[NSString stringWithFormat:@"Telefone: %@",[contato.telefone stringValue]]];
    [_txtCelular setText:[NSString stringWithFormat:@"Celular: %@",[contato.celular stringValue]]];
    [_txtEndereco setText:contato.endereco];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated {
    NSData *contatoRecebido = [[NSUserDefaults standardUserDefaults] objectForKey:@"contatoModificado"];
    if (contatoRecebido != nil) {
        contato = [NSKeyedUnarchiver unarchiveObjectWithData:contatoRecebido];
        [self exibirDadosContato];
    }
}

@end
