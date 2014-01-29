//
//  FirstViewController.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDetailViewController.h"

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FriendDetailViewControllerDelegate>

@property (nonatomic, strong) NSString *mainSearchString;

- (void)performSearch:(NSString *)text;

@end
