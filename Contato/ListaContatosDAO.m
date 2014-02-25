//
//  ListaContatosDAO.m
//  Contato
//
//  Created by André Gimenez Faria on 21/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ListaContatosDAO.h"

@implementation ListaContatosDAO

-(id)init {
    self = [super init];
    if (self) {
        contatosSalvos = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(NSArray *)retornarArrayDaLetra:(char)l{
    NSData *arrayArmazenado = [contatosSalvos objectForKey:[NSString stringWithFormat:@"%c",l]];
    if (arrayArmazenado != nil) {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:arrayArmazenado];
        return array;
    }
    else return nil;
}

-(void) persistirListaContatos:(NSMutableArray *)lista ComLetra:(char)l {
    NSData *arrayParaArmazenar = [NSKeyedArchiver archivedDataWithRootObject:lista];
    [contatosSalvos setObject:arrayParaArmazenar forKey:[NSString stringWithFormat:@"%c",l]];
    [contatosSalvos synchronize];
}


@end
