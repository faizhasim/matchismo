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
@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    [NSException raise:@"MethodNotImplemented"
                format:@"Class %@ failed to implement required method %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    return nil;
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

/**
 * Refer to MatchingCardGameViewController for implementation example
 */
- (IBAction)redeal {
    self.gameResult = nil;
    self.flipCount = 0;
    self.game = nil;
    [self updateUI];
}

- (void)updateButtonUI:(UIButton*)cardButton
{

}

- (NSAttributedString *)lastFlipResultsLabelAttributedText
{
    return [[NSAttributedString alloc] initWithString:@""];
}

- (void)updateUI
{
    if (self.cardButtons && self.cardButtons.count) {
        for (UIButton *cardButton in self.cardButtons) {
            [self updateButtonUI:cardButton];
        }
    }
    
    self.lastFlipResultsLabel.attributedText = [self lastFlipResultsLabelAttributedText];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (IBAction)onMatchModeSelectionChange {
    [self redeal];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    self.flipCount++;
    self.gameResult.score = self.game.score;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}

@end
