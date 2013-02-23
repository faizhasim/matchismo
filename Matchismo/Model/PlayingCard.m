//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 2/21/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;   // implemented both setter and getter

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] > 0) {
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherPlayingCard = (PlayingCard *) otherCard;
                if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                    score += 1;
                } else if (otherPlayingCard.rank == self.rank) {
                    score += 4;
                } else {
                    score = 0;
                    break;
                }
            }
        }
    }
    return score;
}


+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",
             @"A",
             @"2",
             @"3",
             @"4",
             @"5",
             @"6",
             @"7",
             @"8",
             @"9",
             @"10",
             @"J",
             @"Q",
             @"K"];
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
