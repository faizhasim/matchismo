//
//  MatchingCardGameViewController.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 3/16/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "MatchingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchingCardGameViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSelection;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation MatchingCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                                  matchMode:self.matchModeSelection.selectedSegmentIndex + 2];
    }
    return _game;
}

- (IBAction)redeal {
    self.matchModeSelection.enabled = YES;
    [super redeal];
}

- (void)updateButtonUI:(UIButton*)cardButton
{
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.selected = card.isFaceUp;
    cardButton.enabled = !card.isUnplayable;
    cardButton.alpha = card.isUnplayable? 0.3 : 1.0;
    
    [cardButton setImage:[UIImage imageNamed:@"card-back.png"] forState:UIControlStateNormal];
    cardButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    if (card.isFaceUp) {
        [cardButton setImage:nil forState:UIControlStateNormal];
        [cardButton setImage:[UIImage imageNamed:@"card-back.png"] forState:UIControlStateSelected|UIControlStateHighlighted];
    }
    
}

- (NSAttributedString *)lastFlipResultsLabelAttributedText
{
    NSString *returnedString = @"";
    if (self.game.flippedCards.count) {
        NSString *contentsString = [self.game.flippedCards componentsJoinedByString:@", "];
        if (self.game.flippedCards.count > 1) {
            contentsString = [contentsString stringByReplacingOccurrencesOfString:@", "
                                                                       withString:@" & "
                                                                          options:0
                                                                            range:NSMakeRange((self.game.flippedCards.count - 2) * (((Card *)self.game.flippedCards[0]).description.length + 2), (((Card *)self.game.flippedCards[0]).description.length + 2))];
        }
        if (self.game.flippedCards.count < self.game.matchMode) {
            returnedString = [NSString stringWithFormat:@"Flipped up %@", contentsString];
        } else if (self.game.flippedCards.count == self.game.matchMode) {
            if (self.game.scoreChange > 0) {
                returnedString = [NSString stringWithFormat:@"Matched %@ for %d points", contentsString, ABS(self.game.scoreChange + ABS(DefaultFlipCost))];
            } else {
                returnedString = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", contentsString, ABS(self.game.scoreChange + ABS(DefaultFlipCost))];
            }
        }
    }
    return [[NSAttributedString alloc] initWithString:returnedString];
}


- (IBAction)flipCard:(UIButton *)sender
{
    self.matchModeSelection.enabled = NO;
    [super flipCard: sender];    
}



@end
