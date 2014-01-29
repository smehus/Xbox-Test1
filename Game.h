//
//  Game.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/31/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface Game : NSObject

@property (nonatomic, strong) id gameId;
@property (nonatomic, strong) NSString *gameTitle;
@property (nonatomic, strong) NSString *gameBoxArt;
@property (nonatomic, strong) NSString *gameLargeBoxArt;
@property (nonatomic, strong) id earnedGameScore;
@property (nonatomic, strong) id possibleGameScore;
@property (nonatomic, strong) id earnedGameAchievements;
@property (nonatomic, strong) id possibleGameAchievements;
@property (nonatomic, strong) id percentageGameComplete;
@property (nonatomic, strong) id gameLastPlayed;


- (NSComparisonResult)compareName:(Game *)other;

@end
