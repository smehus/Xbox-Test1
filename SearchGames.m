//
//  SearchGames.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/31/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "SearchGames.h"
#import "AFJSONRequestOperation.h"
#import "Game.h"
#import "GamesPlayedViewController.h"

static NSOperationQueue *queue = nil;

@implementation SearchGames {
    
    //NSOperationQueue *queue;
    NSMutableArray *games;
    NSArray *sortDescriptors;
   
}

+ (void)initialize {
    
    if (self == [SearchGames class]) {
        queue = [[NSOperationQueue alloc] init];
    
     
        
    }
    
}

- (id)init {
    
    if (self = [super init]) {
    self.searchResults = [NSMutableArray arrayWithCapacity:20];
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"earnedGameScore" ascending:YES];
        sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    }
    
    return self;
}


- (NSURL *)urlWithSearchText:(NSString *)searchText {

    NSString *escapedString = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlText = [NSString stringWithFormat:@"http://www.xboxleaders.com/api/games.json?gamertag=%@&region=en-US", escapedString];
    NSURL *url = [NSURL URLWithString:urlText];
    return url;
    
}

- (void)sortGames {
    

}



- (void)performSearchWithText:(NSString *)text completion:(SearchBlock)block {
    
    NSURL *url = [self urlWithSearchText:text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    games = [[NSMutableArray alloc] init];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                        JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                            
                            //NSLog(@"Gamesearchsuccess %@", JSON);
                            
                            NSDictionary *data = [JSON objectForKey:@"data"];
                            self.gameCount = [data objectForKey:@"GameCount"];
                            self.totalEarnedAchievements = [data objectForKey:@"location"];
                            self.totalPossibleAchievements = [data objectForKey:@"TotalPossibleAchievements"];
                            self.percentCompleted = [data objectForKey:@"TotalPercentCompleted"];
                            
                            if (games != nil) {
                                games = nil;
                            }
                            
                            games = [NSMutableArray arrayWithCapacity:30];
                            games = [data objectForKey:@"games"];
                            
                            

                            
                            
                            
                            for (NSDictionary *resultDict in games) {
                                NSLog(@"%@", [resultDict objectForKey:@"title"]);
                                
                                Game *game = [[Game alloc] init];
                                game.gameId = [resultDict objectForKey:@"id"];
                                game.gameTitle = [resultDict objectForKey:@"title"];
                                NSDictionary *artwork = [resultDict objectForKey:@"artwork"];
                                game.gameBoxArt = [artwork objectForKey:@"small"];
                                game.gameLargeBoxArt = [artwork objectForKey:@"large"];
                                NSDictionary *gamerScore = [resultDict objectForKey:@"gamerscore"];
                                game.earnedGameScore = [gamerScore objectForKey:@"current"];
                                game.possibleGameScore = [gamerScore objectForKey:@"total"];
                                NSDictionary *achievements = [resultDict objectForKey:@"achievements"];
                                game.earnedGameAchievements = [achievements objectForKey:@"current"];
                                game.possibleGameAchievements = [achievements objectForKey:@"total"];
                                game.percentageGameComplete = [resultDict objectForKey:@"progress"];
                                game.gameLastPlayed = [resultDict objectForKey:@"LastPlayed"];
                                
                                [self.searchResults addObject:game];

                                
                                //[self.searchResults sortedArrayUsingDescriptors:sortDescriptors];
                                
                                [self.searchResults sortUsingSelector:@selector(compareName:)];
                                

                                
                                
                               //NSLog(@"%@", self.searchResults);

                                
                            }
                            
                            
                           
                            block(YES);
                            
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                            NSLog(@"GameSearchFAil");
                        }];
    
    [queue addOperation:operation];
}





@end
