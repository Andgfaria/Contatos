//
//  ViewController.h
//  Contato
//
//  Created by André Gimenez Faria on 20/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerCriacaoContato : UIViewController
- (IBAction)voltar:(id)sender;
- (IBAction)criarContato:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtSobrenome;
@property (weak, nonatomic) IBOutlet UITextField *txtCelular;
@property (weak, nonatomic) IBOutlet UITextField *txtTelefone;
@property (weak, nonatomic) IBOutlet UITextField *txtEndereco;
@property (weak, nonatomic) IBOutlet UIImageView *imagemContato;
@property (weak, nonatomic) IBOutlet UIButton *btnTirarFoto;
- (IBAction)foto:(id)sender;

@end
