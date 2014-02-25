//
//  ViewControllerDetalhesContato.h
//  Contato
//
//  Created by André Gimenez Faria on 21/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface ViewControllerDetalhesContato : UIViewController {
    Contato *contato;
}
@property (weak, nonatomic) IBOutlet UILabel *txtNomeSobrenome;
@property (weak, nonatomic) IBOutlet UILabel *txtTelefone;
@property (weak, nonatomic) IBOutlet UILabel *txtCelular;
@property (weak, nonatomic) IBOutlet UILabel *txtEndereco;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contato:(Contato *)c;

@end
