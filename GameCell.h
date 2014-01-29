//
//  GameCell.h
//  Xbox-Test1
//
//  Created by scott mehus on 2/4/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *gameTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *gameScoreLabel;
@property (nonatomic, weak) IBOutlet UIImageView *boxArtImageView;

@end
