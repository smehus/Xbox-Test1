//
//  GameDetailViewController.h
//  Xbox-Test1
//
//  Created by scott mehus on 2/1/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *gameIdLabel;
@property (nonatomic, weak) IBOutlet UILabel *gameTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *gameScoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalAchievementsLabel;
@property (nonatomic, weak) IBOutlet UIImageView *boxArtImageView;




@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) NSString *searchGameTag;




@end
