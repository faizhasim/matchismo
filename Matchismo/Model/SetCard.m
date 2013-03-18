//
//  SetCard.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 3/13/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
    
@end


@implementation SetCard

+ (NSArray *)validNumbers
{
    return @[@1, @2, @3];
}

+ (NSArray *)validSymbols
{
    return @[@(SetCardSymbolDiamond), @(SetCardSymbolSquiggle), @(SetCardSymbolOval)];
}

+ (NSArray *)validShades
{
    return @[@(SetCardShadeOpen), @(SetCardShadeSolid), @(SetCardShadeStriped)];
}

+ (NSArray *)validColor
{
    return @[@(SetCardColorRed), @(SetCardColorGreen), @(SetCardColorPurple)];
}

- (void)setNumber:(NSUInteger)number
{
    if ([[SetCard validNumbers] containsObject:@(number)]) {
        _number = number;
    }
}

- (void)setSymbol:(SetCardSymbol)symbol
{
    if ([[SetCard validSymbols] containsObject:@(symbol)]) {
        _symbol = symbol;
    }
}

- (void)setShade:(SetCardShade)shade
{
    if ([[SetCard validShades] containsObject:@(shade)]) {
        _shade = shade;
    }
}

- (void)setColor:(SetCardColor)color
{
    if ([[SetCard validColor] containsObject:@(color)]) {
        _color = color;
    }
}

- (int)match:(NSArray *)otherCards
{
    BOOL isAllNumberSame = YES;
    BOOL isAllNumberUnique = YES;
    BOOL isAllSymbolSame = YES;
    BOOL isAllSymbolUnique = YES;
    BOOL isAllShadeSame = YES;
    BOOL isAllShadeUnique = YES;
    BOOL isAllColorSame = YES;
    BOOL isAllColorUnique = YES;
    
    NSMutableArray* otherCardsCopy = [otherCards mutableCopy];
    SetCard *cardForComparison = self;
    while ([otherCardsCopy count] > 0) {
        for (id aCard in otherCardsCopy) {
            if (![aCard isKindOfClass:[[self class] class]]) {
                return 0;
            }
            SetCard *setCard = (SetCard *) aCard;
            
            if (setCard.number == cardForComparison.number) {
                isAllNumberUnique = NO;
            } else {
                isAllNumberSame = NO;
            }
            
            if (setCard.symbol == cardForComparison.symbol) {
                isAllSymbolUnique = NO;
            } else {
                isAllSymbolSame = NO;
            }
            
            if (setCard.shade == cardForComparison.shade) {
                isAllShadeUnique = NO;
            } else {
                isAllShadeSame = NO;
            }
            
            if (setCard.color == cardForComparison.color) {
                isAllColorUnique = NO;
            } else {
                isAllColorSame = NO;
            }
        }
        
        cardForComparison = [otherCardsCopy lastObject];
        [otherCardsCopy removeLastObject];
    }
    
    if ( (isAllNumberSame ^ isAllNumberUnique) &&
        (isAllSymbolSame ^ isAllSymbolUnique) &&
        (isAllShadeSame ^ isAllShadeUnique) &&
        (isAllColorSame ^ isAllColorUnique) ) {
        return 10;
    }
    return -5;
}

- (NSString*)contents
{
    return [NSString stringWithFormat:@"%d %d [shade:%d] [color:%d]", self.number, self.symbol, self.shade, self.color];
}

@end
