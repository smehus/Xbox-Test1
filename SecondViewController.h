//
//  SecondViewController.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *homeSearchBar;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *gameCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *percentCompletedLabel;
@property (nonatomic, weak) IBOutlet UILabel *earnedAchievementsLabel;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *gamesArray;

@property (nonatomic, strong) NSString *searchString;

@end
