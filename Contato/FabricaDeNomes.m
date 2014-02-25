//
//  FabricaDeNomes.m
//  Contato
//
//  Created by André Gimenez Faria on 18/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "FabricaDeNomes.h"
#import <time.h>

@implementation FabricaDeNomes


+(FabricaDeNomes *)sharedInstance {
    static FabricaDeNomes *fabricaNomes = nil;
    if (!fabricaNomes) {
        srand(time(NULL));
        fabricaNomes = [[super alloc] init];
        [fabricaNomes criarRelacaoNomes];
    }
    return fabricaNomes;
}

-(void) criarRelacaoNomes {
    relacaoNomes = [[NSMutableDictionary alloc] init];
    [relacaoNomes setObject:@"André" forKey:@"1"];
    [relacaoNomes setObject:@"Breno" forKey:@"2"];
    [relacaoNomes setObject:@"Carlos" forKey:@"3"];
    [relacaoNomes setObject:@"Débora" forKey:@"4"];
    [relacaoNomes setObject:@"Eduardo" forKey:@"5"];
    [relacaoNomes setObject:@"Flora" forKey:@"6"];
    [relacaoNomes setObject:@"Gustavo" forKey:@"7"];
    [relacaoNomes setObject:@"Henrique" forKey:@"8"];
    [relacaoNomes setObject:@"Ines" forKey:@"9"];
    [relacaoNomes setObject:@"Jorge" forKey:@"10"];
    [relacaoNomes setObject:@"Ka" forKey:@"11"];
    [relacaoNomes setObject:@"Lucas" forKey:@"12"];
    [relacaoNomes setObject:@"Maria" forKey:@"13"];
    [relacaoNomes setObject:@"Nair" forKey:@"14"];
    [relacaoNomes setObject:@"Otavio" forKey:@"15"];
    [relacaoNomes setObject:@"Pedro" forKey:@"16"];
    [relacaoNomes setObject:@"Queiroz" forKey:@"17"];
    [relacaoNomes setObject:@"Renato" forKey:@"18"];
    [relacaoNomes setObject:@"Silvia" forKey:@"19"];
    [relacaoNomes setObject:@"Tania" forKey:@"20"];
    [relacaoNomes setObject:@"Ursula" forKey:@"21"];
    [relacaoNomes setObject:@"Vanessa" forKey:@"22"];
    [relacaoNomes setObject:@"Wagner" forKey:@"23"];
    [relacaoNomes setObject:@"Xavier" forKey:@"24"];
    [relacaoNomes setObject:@"Yuri" forKey:@"25"];
    [relacaoNomes setObject:@"Zé" forKey:@"26"];
}

-(NSString *)nomeAleatorio {
    
    NSNumber *numeroAleatorio  = [[NSNumber alloc] initWithInt:(rand() % 26 + 1)];
    return [relacaoNomes objectForKey:[numeroAleatorio stringValue]];
}



@end
