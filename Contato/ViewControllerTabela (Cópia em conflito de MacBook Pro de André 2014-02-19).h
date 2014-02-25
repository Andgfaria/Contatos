//
//  ViewControllerTabela.h
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerTabela : UITableViewController {
    NSMutableArray *listaContatos;
    int ocorrencias[26];
    int ocorrenciasPreenchidas[26];
}

@end
