//
//  FriendDetailViewController.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/29/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

@class FriendDetailViewController;

@protocol FriendDetailViewControllerDelegate <NSObject>


//- (void)friendDetail:(FriendDetailViewController *)controller didPickGamer:(NSString *)gamerTag;

@end

@interface FriendDetailViewController : UIViewController

@property (nonatomic, weak) id <FriendDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) Friend *friend;

@property (nonatomic, weak) IBOutlet UIImageView *friendAvatarImage;
@property (nonatomic, weak) IBOutlet UILabel *friendTagLabel;
@property (nonatomic, weak) IBOutlet UILabel *friendScoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *onlineStatusLabel;

@property (nonatomic, weak) IBOutlet UILabel *mottoLabel;


@property (nonatomic, weak) IBOutlet UIImageView *gameImageView;

@end
