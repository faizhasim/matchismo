//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 2/20/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSelection;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResultsLabel;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

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
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)onMatchModeSelectionChange {
    [self redeal];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
//    self.lastFlipResultsLabel.text = @"";
    
    NSMutableArray *faceUpCards = [[NSMutableArray alloc] initWithCapacity:2];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable? 0.3 : 1.0;
        
        [cardButton setImage:[UIImage imageNamed:@"card-back.png"] forState:UIControlStateNormal];
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        if (card.isFaceUp) {
            [faceUpCards addObject:card];
            [cardButton setImage:nil forState:UIControlStateNormal];
            [cardButton setImage:[UIImage imageNamed:@"card-back.png"] forState:UIControlStateSelected|UIControlStateHighlighted];
            
        }
    }
    
    self.lastFlipResultsLabel.text = [NSString stringWithFormat:@""];
    if (self.game.flippedCards.count > 0) {
        NSString *contentsString = [self.game.flippedCards componentsJoinedByString:@", "];
        if (self.game.flippedCards.count > 1) {
            contentsString = [contentsString stringByReplacingOccurrencesOfString:@", "
                                                                       withString:@" & "
                                                                          options:0
                                                                            range:NSMakeRange((self.game.flippedCards.count - 2) * (((Card *)self.game.flippedCards[0]).description.length + 2), (((Card *)self.game.flippedCards[0]).description.length + 2))];
        }
        if (self.game.flippedCards.count < self.game.matchMode) {
            self.lastFlipResultsLabel.text = [NSString stringWithFormat:@"Flipped up %@", contentsString];
        } else if (self.game.flippedCards.count == self.game.matchMode) {
            if (self.game.scoreChange > 0) {
                self.lastFlipResultsLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points", contentsString, ABS(self.game.scoreChange + ABS(FLIP_COST))];
            } else {
                self.lastFlipResultsLabel.text = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", contentsString, ABS(self.game.scoreChange + ABS(FLIP_COST))];
            }
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    self.matchModeSelection.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.gameResult.score = self.game.score;
    [self updateUI];
}

@end
