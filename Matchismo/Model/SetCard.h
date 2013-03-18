//
//  SetCard.h
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 3/13/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "Card.h"

typedef enum {
    SetCardSymbolDiamond = 1,
    SetCardSymbolSquiggle,
    SetCardSymbolOval
} SetCardSymbol;

typedef enum {
    SetCardShadeSolid = 1,
    SetCardShadeStriped,
    SetCardShadeOpen
} SetCardShade;

typedef enum {
    SetCardColorRed = 1,
    SetCardColorGreen,
    SetCardColorPurple
} SetCardColor;

@interface SetCard : Card

+ (NSArray *)validNumbers;
+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColor;

@property (nonatomic) NSUInteger number;
@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) SetCardShade shade;
@property (nonatomic) SetCardColor color;


@end
