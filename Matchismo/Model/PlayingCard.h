//
//  PlayingCard.h
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 2/21/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
