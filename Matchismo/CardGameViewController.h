//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Mohd Faiz Hasim on 2/20/13.
//  Copyright (c) 2013 Mohd Faiz Hasim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)redeal;
- (IBAction)flipCard:(UIButton *)sender;
@end
