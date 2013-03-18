//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 3/14/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        for (id color in [SetCard validColor]) {
            for (id number in [SetCard validNumbers]) {
                    for (id shade in [SetCard validShades]) {
                            for (id symbol in [SetCard validSymbols]) {
                                SetCard *aSetCard = [[SetCard alloc] init];
                                aSetCard.color = [color intValue];
                                aSetCard.number = [number intValue];
                                aSetCard.shade = [shade intValue];
                                aSetCard.symbol = [symbol intValue];
                                [self addCard:aSetCard atTop:YES];
                            }
                    }
            }
        }
    }
    return self;
}

@end
