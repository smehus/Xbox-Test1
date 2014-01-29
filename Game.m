//
//  Game.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/31/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "Game.h"

@implementation Game


- (NSComparisonResult)compareName:(Game *)other {
    
    return [other.earnedGameScore compare:self.earnedGameScore];
    
}


@end
