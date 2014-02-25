//
//  FabricaContatos.m
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "FabricaContatos.h"
#import "Contato.h"

@implementation FabricaContatos

+(FabricaContatos *) sharedInstance {
    static FabricaContatos *fabricaContatos = nil;
    if (!fabricaContatos) {
        fabricaContatos = [[super allocWithZone:nil] init];
    }
    return fabricaContatos;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

-(Contato *) criarContato {
    Contato *novo = [[Contato alloc] init];
    return novo;
}

@end
