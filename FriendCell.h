//
//  FriendCell.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@interface FriendCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *friendTagLabel;
@property (nonatomic, weak) IBOutlet UILabel *friendScoreLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;



- (void)configureForSearchResults:(Friend *)pal;

@end
