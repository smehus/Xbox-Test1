//
//  Gamer.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gamer : NSObject

@property (nonatomic, strong) NSString *gamerTag;
@property (nonatomic, strong) id gamerScore;
@property (nonatomic, strong) NSString *avatarImageView;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSNumber *onlineStatus;
@property (nonatomic, strong) NSString *motto;
@property (nonatomic, strong) NSString *tier;
@property (nonatomic, strong) id gameCount;
@property (nonatomic, strong) id earnedAchievements;
@property (nonatomic, strong) id percentCompleted;

@end
