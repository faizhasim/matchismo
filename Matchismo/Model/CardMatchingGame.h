//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 2/21/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject
#define MATCH_BONUS 4
#define MISMATCH_PENALTY -2
#define FLIP_COST -1



// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck
              matchMode:(NSUInteger)matchMode;

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)redealUsingDeck:(Deck *)deck
              matchMode:(NSUInteger)matchMode;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) int scoreChange;
@property (readonly, nonatomic, strong) NSArray* flippedCards;
@property (readonly, nonatomic) NSUInteger matchMode;


@end
