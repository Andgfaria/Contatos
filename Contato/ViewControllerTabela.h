//
//  ViewControllerCriacaoContatoTabela.h
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerTabela : UITableViewController {
    NSMutableArray *listaContatos[26];
    UIView *header;
    IBOutlet UIView *viewHeader;
}
@property (weak, nonatomic) IBOutlet UIButton *btnEditar;
- (IBAction)ativarEdicao:(id)sender;
- (IBAction)ativarViewCriarContato:(id)sender;


@end
