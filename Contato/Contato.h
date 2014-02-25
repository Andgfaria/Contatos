//
//  Contato.h
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FabricaDeNomes.h"

@interface Contato : NSObject <NSCoding>

@property NSString *nome;
@property NSString *sobrenome;
@property NSNumber *telefone;
@property NSNumber *celular;
@property NSString *endereco;

-(id)init;
-(id)initWithNome:(NSString *)n eSobrenome:(NSString *)s eTelefone:(NSNumber *)t eCelular:(NSNumber *)c eEndereco:(NSString *)e;

@end
