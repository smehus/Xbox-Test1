//
//  SecondViewController.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "SecondViewController.h"
#import "AFJSONRequestOperation.h"
#import "Gamer.h"
#import "UIImageView+AFNetworking.h"
#import "FirstViewController.h"
#import "SearchGames.h"
#import "GamesPlayedViewController.h"

@interface SecondViewController ()

@property (nonatomic, weak) IBOutlet UILabel *gamerTagLabel;
@property (nonatomic, weak) IBOutlet UILabel *gamerScoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *onlineStatusLabel;
@property (nonatomic, weak) IBOutlet UILabel *tierLabel;
@property (nonatomic, weak) IBOutlet UILabel *mottoLabel;
@property (nonatomic, weak) IBOutlet UILabel *bioLabel;




@end

@implementation SecondViewController {
    
    NSOperationQueue *queue;
    Gamer *gamer;
    SearchGames *searchGame;
    GamesPlayedViewController *gamesController;
    BOOL isLoading;
    
    id gamesCount;
    id totalAchievements;
    id completion;
    NSString *myMotto;
   

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.homeSearchBar becomeFirstResponder];
    queue = [[NSOperationQueue alloc] init];
    
        gamer = [[Gamer alloc] init];
     searchGame = [[SearchGames alloc] init];
    self.gamesArray = [NSMutableArray arrayWithCapacity:20];
    
    UINavigationController *navController = (UINavigationController *)[[self.tabBarController viewControllers] objectAtIndex:2];
     gamesController = (GamesPlayedViewController *)[[navController viewControllers] objectAtIndex:0];
    
    self.gameCountLabel.text = @"";
    self.percentCompletedLabel.text = @"";
    self.earnedAchievementsLabel.text = @"";
    self.gamerTagLabel.text = @"";
    self.gamerScoreLabel.text = @"";
    self.onlineStatusLabel.text = @"";
    self.tierLabel.text = @"";
    self.bioLabel.text = @"";
    
    gamesCount = @"";
    totalAchievements = @"";
    completion = @"";

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSURL *)urlWithSearchText:(NSString *)searchText {
    
    NSString *escapedString = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *search = [NSString stringWithFormat:@"http://www.xboxleaders.com/api/profile.json?gamertag=%@&region=en-US", escapedString];
    NSURL *url = [NSURL URLWithString:search];
    return url;
}

- (void)updateLabels {
    NSLog(@"***UPDATELABELS***");
  
    
    
    if (isLoading) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        self.gameCountLabel.text = @"";
        self.percentCompletedLabel.text = @"";
        self.earnedAchievementsLabel.text = @"";
        self.gamerTagLabel.text = @"";
        self.gamerScoreLabel.text = @"";
        self.onlineStatusLabel.text = @"";
        self.tierLabel.text = @"";
        self.bioLabel.text = @"";
        
    } else {

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        

            
            self.gamerTagLabel.text = gamer.gamerTag;
            self.gamerScoreLabel.text = [NSString stringWithFormat:@"%@", gamer.gamerScore];
            self.onlineStatusLabel.text = [NSString stringWithFormat:@"%@",gamer.onlineStatus];
            self.tierLabel.text = gamer.tier;
            self.mottoLabel.text = [NSString stringWithFormat:@"'%@'", gamer.motto];
            
       

    NSLog(@"***UPDATE LABELS %@", gamer.gamerScore);
        
        gamesCount = gamer.gameCount;
        totalAchievements = gamer.earnedAchievements;
        completion = gamer.percentCompleted;
        myMotto = gamer.motto;
        
    [self.tableView reloadData];
  
    
    self.gameCountLabel.text = [NSString stringWithFormat:@"%@", gamer.gameCount];
    self.percentCompletedLabel.text = [NSString stringWithFormat:@"%% %@", gamer.percentCompleted];
    self.earnedAchievementsLabel.text = [NSString stringWithFormat:@"%@", gamer.earnedAchievements];
    self.bioLabel.text = gamer.bio;
    
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:gamer.avatarImageView] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
        
        
    
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    isLoading = YES;
    [self.tableView reloadData];

    
    if ([searchBar.text length] > 0) {
        
        [self updateLabels];
        [self.homeSearchBar resignFirstResponder];
        
        [gamesController updateViewController];
         [gamesController.tableView reloadData];
        
        [searchGame performSearchWithText:searchBar.text completion:^(BOOL success) {
           
            gamer.gameCount = [NSString stringWithFormat:@"%@", searchGame.gameCount];
            gamer.percentCompleted = [NSString stringWithFormat:@"%@", searchGame.percentCompleted];
            
            
            

            
            self.gamesArray = searchGame.searchResults;
            
            gamesController.games = searchGame.searchResults;
            gamesController.gamerTag = searchBar.text;

            [gamesController.tableView reloadData];
            [self updateLabels];
            
            
        }];
        
       
        
        NSURL *url = [self urlWithSearchText:searchBar.text];
        
        
        UINavigationController *navigationController = (UINavigationController *)[[self.tabBarController viewControllers] objectAtIndex:1];
        FirstViewController *controller = (FirstViewController *)[[navigationController viewControllers] objectAtIndex:0];
       
       //FirstViewController *controller =  (FirstViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
        controller.mainSearchString = searchBar.text;
        [controller performSearch:searchBar.text];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation
                        JSONRequestOperationWithRequest:request
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                
                                                 
                                                 
                                                 
                                                 NSDictionary *result = [JSON objectForKey:@"data"];
                                                 NSDictionary *avatar = [result objectForKey:@"avatar"];
                                                 gamer.gamerTag = [result objectForKey:@"gamertag"];
                                                 gamer.gamerScore = [result objectForKey:@"gamerscore"];
                                                 gamer.avatarImageView = [avatar objectForKey:@"full"];
                                                 gamer.onlineStatus = [result objectForKey:@"online"];
                                                 gamer.tier = [result objectForKey:@"Tier"];
                                                 gamer.motto = [result objectForKey:@"motto"];
                                                 //gamer.bio = [result objectForKey:@"biography"];
                                                 gamer.earnedAchievements = [result objectForKey:@"location"];
                                                 

                                                 isLoading = NO;
                                                 [self updateLabels];
                                                 
                                                 
                                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                 NSLog(@"MAIN GAMER GRAB Fail");
                                                 
                                                 
                                                 
                                             }];
        [queue addOperation:operation];
        
        
        
        
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
   // UILabel *titleLabel = (UILabel *)[cell viewWithTag:1001];

    
    
    if (indexPath.row == 0 ) {
        
       
        
        label.text = gamer.gamerTag;
        label.textAlignment = NSTextAlignmentCenter;
     
    } else if (indexPath.row == 1) {
        
         // THIS IS WHAT WORKS USE THIS DAMNIT
        if (isLoading == NO) {
            if (!gamer.gamerScore) {
                label.text = @"";
            } else {
                label.text = [NSString stringWithFormat:@"%@ XP", gamer.gamerScore];
            }
            
        } else {
            label.text = @"";
        }
        
    
        
    } else if (indexPath.row == 2) {
     
        
        label.text = @"";
        if ([myMotto isEqualToString:@""]) {
            label.text = @"(No Motto)";
        } else {
            label.text = myMotto;
        }
        
    } else if (indexPath.row == 3) {
      
        
        if (gamer.onlineStatus == 0) {
            label.text = @"Offline";
        } else {
            label.text = @"Online";
        }
        label.textAlignment = NSTextAlignmentCenter;


        
    }

    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}













@end
