//
//  Friend.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, strong) NSString *friendTag;
@property (nonatomic, strong) id friendScore;
@property (nonatomic, strong) NSString *avatarImage;
@property (nonatomic, assign) BOOL onlineStatus;
@property (nonatomic, strong) NSString *avatarLargeImage;
@property (nonatomic, strong) NSString *gameURL;


@end
