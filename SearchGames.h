//
//  SearchGames.h
//  Xbox-Test1
//
//  Created by scott mehus on 1/31/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

typedef void (^SearchBlock)(BOOL success);

@interface SearchGames : NSObject


@property (nonatomic, strong) id gameCount;
@property (nonatomic, strong) id totalEarnedScore;
@property (nonatomic, strong) id totalPossibleScore;
@property (nonatomic, strong) id totalEarnedAchievements;
@property (nonatomic, strong) id totalPossibleAchievements;
@property (nonatomic, strong) id percentCompleted;

@property (nonatomic, strong) NSMutableArray *searchResults;

- (NSComparisonResult)compareName:(Game *)other;

- (void)performSearchWithText:(NSString *)text completion:(SearchBlock)block;
- (NSMutableArray *)PlayedGamesArray;


@end
