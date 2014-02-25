//
//  Contato.m
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@synthesize nome;
@synthesize sobrenome;
@synthesize telefone;
@synthesize celular;
@synthesize endereco;

-(id)init {
    self = [super init];
    if (self) {
        FabricaDeNomes *fabricaNomes = [FabricaDeNomes sharedInstance];
        nome = [fabricaNomes nomeAleatorio];
        sobrenome = @"Silva";
        telefone = @123456;
        celular = @654321;
        endereco = @"Mackenzie";
    }
    return self;
}

-(id)initWithNome:(NSString *)n eSobrenome:(NSString *)s eTelefone:(NSNumber *)t eCelular:(NSNumber *)c eEndereco:(NSString *)e {
    self = [super init];
    if (self) {
        nome = n;
        sobrenome = s;
        telefone = t;
        celular = c;
        endereco = e;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        nome = [aDecoder decodeObjectForKey:@"nome"];
        sobrenome = [aDecoder decodeObjectForKey:@"sobrenome"];
        telefone = [aDecoder decodeObjectForKey:@"telefone"];
        celular = [aDecoder decodeObjectForKey:@"celular"];
        endereco = [aDecoder decodeObjectForKey:@"endereco"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:nome forKey:@"nome"];
    [aCoder encodeObject:sobrenome forKey:@"sobrenome"];
    [aCoder encodeObject:telefone forKey:@"telefone"];
    [aCoder encodeObject:celular forKey:@"celular"];
    [aCoder encodeObject:endereco forKey:@"endereco"];
}

@end
