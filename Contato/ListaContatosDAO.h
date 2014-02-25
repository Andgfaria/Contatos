//
//  ListaContatosDAO.h
//  Contato
//
//  Created by André Gimenez Faria on 21/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListaContatosDAO : NSObject {
    NSUserDefaults *contatosSalvos;
}

-(id)init;
-(NSArray *) retornarArrayDaLetra:(char)l;
-(void) persistirListaContatos:(NSMutableArray *)lista ComLetra:(char)l;

@end
