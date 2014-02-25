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
	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
