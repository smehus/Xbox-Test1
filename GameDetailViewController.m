//
//  GameDetailViewController.m
//  Xbox-Test1
//
//  Created by scott mehus on 2/1/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "GameDetailViewController.h"
#import "AFJSONRequestOperation.h"
#import "Game.h"
#import "Achievement.h"
#import "AFImageCache.h"
#import "UIImageView+AFNetworking.h"

@interface GameDetailViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@end

@implementation GameDetailViewController {
    
    NSOperationQueue *queue;
    //Game *currentGame;
    NSMutableArray *achievementsArray;
    NSMutableArray *achievementObjects;
    NSOperationQueue *imageRequestOperationQueue;
}

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    //currentGame = [[Game alloc] init];
    queue = [[NSOperationQueue alloc] init];
    [self performSearch];
    [self updateLabels];
    achievementObjects = [NSMutableArray arrayWithCapacity:20];
    
    imageRequestOperationQueue = [[NSOperationQueue alloc] init];
    [imageRequestOperationQueue setMaxConcurrentOperationCount:8];
    
    NSLog(@"%@", self.game.gameLargeBoxArt);
    self.scrollView.backgroundColor = [UIColor clearColor];
    //self.scrollView.contentSize = CGSizeMake(6000, self.scrollView.bounds.size.height);
    
    NSLog(@"%@, %@, %@", self.game.gameTitle, self.game.gameId, self.searchGameTag);
    
    
    [self.boxArtImageView setImageWithURL:[NSURL URLWithString:self.game.gameLargeBoxArt] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tileButtons {
    
    const CGFloat itemWidth = 96.0f;
    const CGFloat itemHeight = 96.0f;
    const CGFloat buttonWidth = 82.0f;
    const CGFloat buttonHeight = 82.0f;
    const CGFloat marginHorz = (itemWidth - buttonWidth)/2.0f;
    const CGFloat marginVert = (itemHeight - buttonHeight)/2.0f;
    
    int index = 0;
    int row = 0;
    int column = 0;
    
    
    for (Achievement *achievement in achievementObjects) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(column*itemWidth + marginHorz, row*itemHeight + marginVert, buttonWidth, buttonHeight);
        [button setBackgroundImage:[UIImage imageNamed:@"LandscapeButton"] forState:UIControlStateNormal];
       
        //[button setTitleEdgeInsets:UIEdgeInsetsMake(50.0, -100.0, 5.0, 5.0)];
        //[button setTitle:achievement.achievementTitle forState:UIControlStateNormal];
        
        
        [self.scrollView addSubview:button];
        
        [self downloadImageForSearchResult:achievement andPlaceOnButton:button];
        
        index++;
        row++;
        if (row == 2) {
            row = 0;
            column++;
        }
    }
    
    int numPages = ceilf([achievementObjects count] / 6.0f);
    self.scrollView.contentSize = CGSizeMake(numPages*288.0f, self.scrollView.bounds.size.height);
    
    NSLog(@"Number of pages: %d", numPages);
    
    
}

- (void)updateLabels {
    
    self.gameIdLabel.text = [NSString stringWithFormat:@"%@", self.game.gameId];
    self.gameScoreLabel.text = [NSString stringWithFormat:@"%@", self.game.earnedGameScore];
    self.gameTitleLabel.text = self.game.gameTitle;
    self.totalAchievementsLabel.text = [NSString stringWithFormat:@"%@", self.game.earnedGameAchievements];
    
    [self tileButtons];
}

- (NSURL *)urlWithSearchText:(NSString  *)text gameID:(id)gameId {
    
    NSString *escapedString = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *searchText = [NSString stringWithFormat:@"http://www.xboxleaders.com/api/achievements.json?gamertag=%@&titleid=%@&region=en-US", escapedString, gameId];

    NSURL *url = [NSURL URLWithString:searchText];
    return url;
}

- (void)performSearch {
    
    achievementsArray = nil;
    
    NSURL *url = [self urlWithSearchText:self.searchGameTag gameID:self.game.gameId];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSLog(@"performSearch: %@", url);

    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             NSLog(@"Success!");
                                             
                                             NSDictionary *data = [JSON objectForKey:@"data"];
                                             achievementsArray = [data objectForKey:@"achievements"];
                                             
                                             for (NSDictionary *resultDict in achievementsArray) {
                                                 
                                                 Achievement *achievment = [[Achievement alloc] init];
                                                 achievment.achievementId = [resultDict objectForKey:@"id"];
                                                 achievment.achievementTitle = [resultDict objectForKey:@"title"];
                                                 achievment.titleURL = [resultDict objectForKey:@"titleUrl"];
                                                 
                                                 
                                                 
                                                 [achievementObjects addObject:achievment];
                                                 
                                             }
                                             
                                           
                                             
                                             
                                              NSLog(@"%d", [achievementObjects count]);
                                             [self updateLabels];
                                             
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             NSLog(@"GAME DETAIL Fail!");
                                         }];
    
     
    [queue addOperation:operation];
}


- (void)downloadImageForSearchResult:(Achievement *)achievement andPlaceOnButton:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:achievement.titleURL];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [urlRequest setHTTPShouldHandleCookies:NO];
    [urlRequest setHTTPShouldUsePipelining:YES];
    
    UIImage *cachedImage = [[AFImageCache sharedImageCache] cachedImageForURL:[urlRequest URL] cacheName:nil];
    if (cachedImage != nil) {
        [button setImage:cachedImage forState:UIControlStateNormal];
    } else {
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [button setImage:responseObject forState:UIControlStateNormal];
            [[AFImageCache sharedImageCache] cacheImageData:operation.responseData forURL:[urlRequest URL] cacheName:nil];
        } failure:nil];
        
        [imageRequestOperationQueue addOperation:requestOperation];
    }
}



- (void)dealloc
{
    NSLog(@"dealloc %@", self);
    [imageRequestOperationQueue cancelAllOperations];
}











@end
