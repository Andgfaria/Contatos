//
//  FabricaDeNomes.h
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FabricaDeNomes : NSObject {
    NSMutableDictionary *relacaoNomes;
}

+(FabricaDeNomes *)sharedInstance;
-(NSString *)nomeAleatorio;

@end
