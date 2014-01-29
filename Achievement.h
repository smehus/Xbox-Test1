//
//  Achievement.h
//  Xbox-Test1
//
//  Created by scott mehus on 2/2/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievement : NSObject


@property (nonatomic, strong) id achievementId;
@property (nonatomic, strong) NSString *titleURL;
@property (nonatomic, strong) NSString *achievementTitle;
@property (nonatomic, strong) NSString *achievementDescription;
@property (nonatomic, strong) id achievementScore;



@end
