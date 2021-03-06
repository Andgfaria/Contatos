//
//  ViewControllerEdicaoContato.h
//  Contato
//
//  Created by André Gimenez Faria on 21/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface ViewControllerEdicaoContato : UIViewController {
    Contato *contato;
    UIActionSheet *opcoesAlterarFoto;
    UIActionSheet *opcoesAdicionarFoto;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contato:(Contato *)c;

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtSobrenome;
@property (weak, nonatomic) IBOutlet UITextField *txtTelefone;
@property (weak, nonatomic) IBOutlet UITextField *txtCelular;
@property (weak, nonatomic) IBOutlet UITextField *txtEndereco;
@property (weak, nonatomic) IBOutlet UIButton *btnAlterarFoto;

@property (weak, nonatomic) IBOutlet UIButton *btnAdicionarFoto;
- (IBAction)alterarFoto:(id)sender;
- (IBAction)adicionarFoto:(id)sender;

@end
