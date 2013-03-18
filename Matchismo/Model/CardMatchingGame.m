//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 2/21/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "CardMatchingGame.h"

const NSUInteger DefaultMatchBonus = 4;
const NSUInteger DefaultMismatchedPenalty = -2;
const NSUInteger DefaultFlipCost = -1;

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) int scoreChange;
@property (readwrite, nonatomic, strong) NSArray* flippedCards;
@property (nonatomic) NSUInteger cardCount;
@property (strong, nonatomic) NSMutableArray *cards; // or Card
@property (readwrite, nonatomic) NSUInteger matchMode;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck
              matchMode:(NSUInteger)matchMode
{
    self = [super init];
    if (self) {
        self.cardCount = count;
        if (matchMode > 1 && matchMode <= 4 && matchMode <= count) {
            self.matchMode = matchMode;
        } else {
            self.matchMode = 2;
        }
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck
{
    return [self initWithCardCount:count usingDeck:deck matchMode:2];
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.scoreChange = 0;
    self.flippedCards = @[];
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *flippedCards = [[NSMutableArray alloc] init];
            NSMutableArray *cardsForComparison = [[NSMutableArray alloc] init];
            [flippedCards addObject:card];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [flippedCards addObject:otherCard];
                    [cardsForComparison addObject:otherCard];
                    if (self.matchMode == 2) {
                        break;
                    }
                }
            }
            self.flippedCards = [NSArray arrayWithArray:flippedCards];
            if ([flippedCards count] == self.matchMode) {
                int matchScore = [card match:cardsForComparison];
                if (matchScore > 0) {
                    card.unplayable = YES;
                    for (Card *otherCard in self.flippedCards) {
                        otherCard.unplayable = YES;
                    }
                    self.scoreChange += matchScore * DefaultMatchBonus;
                } else {
                    for (Card *otherCard in self.flippedCards) {
                        otherCard.faceUp = NO;
                    }
                    self.scoreChange += DefaultMismatchedPenalty;
                }
            }
            
            self.scoreChange += DefaultFlipCost;
        }
        card.faceUp = !card.isFaceUp;
    }
    self.score += self.scoreChange;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])? self.cards[index] : nil;
}

@end
