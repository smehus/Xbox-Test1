//
//  GamesPlayedViewController.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/31/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesPlayedViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *games;
@property (nonatomic, strong) NSString *gamerTag;


- (void)updateViewController;

@end
