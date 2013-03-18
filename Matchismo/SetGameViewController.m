//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 3/13/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@end

@implementation SetGameViewController

+ (NSDictionary *)symbolColor {
    return @{@(SetCardColorRed): [UIColor redColor],
             @(SetCardColorGreen): [UIColor greenColor],
             @(SetCardColorPurple): [UIColor purpleColor]};
}

+ (NSDictionary *)shadeBySymbolColor:(SetCardColor)symbolColor {
    UIColor *symbolUIColor = [[[self class] symbolColor] objectForKey:@(symbolColor)];
    if (!symbolUIColor) {
        symbolUIColor = [UIColor blackColor];
    }
    return @{@(SetCardShadeOpen): [symbolUIColor colorWithAlphaComponent:0.0],
             @(SetCardShadeStriped): [symbolUIColor colorWithAlphaComponent:0.3],
             @(SetCardShadeSolid): [symbolUIColor colorWithAlphaComponent:1.0]};
}

+ (NSString *)setCardContent:(SetCard*)setCard
{
    NSString *stringBuilder = @"";
    for (int i = 0; i < setCard.number; i++) {
        switch (setCard.symbol) {
            case SetCardSymbolDiamond:
                stringBuilder = [stringBuilder stringByAppendingString:@"▲"];
                break;
            case SetCardSymbolOval:
                stringBuilder = [stringBuilder stringByAppendingString:@"●"];
                break;
            case SetCardSymbolSquiggle:
                stringBuilder = [stringBuilder stringByAppendingString:@"■"];
                break;
            default:
                return @"?";
        }
    }
    return stringBuilder;
}

- (CardMatchingGame*)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[SetCardDeck alloc] init]
                                                          matchMode:3];
    return _game;
}

- (void)updateButtonUI:(UIButton*)cardButton
{
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *) card;
        
        UIColor *symbolColor = [[[self class] symbolColor] objectForKey: @(setCard.color)];
        UIColor *shadeColor = [[[self class] shadeBySymbolColor:setCard.color] objectForKey: @(setCard.shade)];
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName: shadeColor,
                                     NSStrokeColorAttributeName: symbolColor,
                                     NSStrokeWidthAttributeName: @-3
                                     };
        
        NSAttributedString *formattedContent = [[NSAttributedString alloc] initWithString:[[self class] setCardContent:setCard]
                                                                               attributes:attributes];
        [cardButton setAttributedTitle:formattedContent
                              forState:UIControlStateNormal];
        [cardButton setAttributedTitle:formattedContent
                              forState:UIControlStateNormal|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.hidden = card.isUnplayable? YES : NO;
        card.isFaceUp? [cardButton setBackgroundColor:[UIColor lightGrayColor]] : [cardButton setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.1]];
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


@end
