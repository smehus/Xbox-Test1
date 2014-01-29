//
//  FirstViewController.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "FirstViewController.h"
#import "Gamer.h"
#import "AFJSONRequestOperation.h"
#import "Friend.h"
#import "SecondViewController.h"
#import "FriendCell.h"
#import "FriendDetailViewController.h"

static NSString *FriendCellIdentifier = @"FriendCell";
static NSString *LoadingCellIdentifier = @"LoadingCell";

@interface FirstViewController ()

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;



@end

@implementation FirstViewController {
    
    NSMutableArray *friends;
    NSOperationQueue *queue;
    SecondViewController *controller;
    BOOL isLoading;
    NSIndexPath *friendIndexPath;
    
    __weak FriendDetailViewController *friendDetailViewController;
}

@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:FriendCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:FriendCellIdentifier];
    
    cellNib = [UINib nibWithNibName:LoadingCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:LoadingCellIdentifier];


    queue = [[NSOperationQueue alloc] init];
    [self performSearch:self.mainSearchString];
    
    NSLog(@"%@", self.mainSearchString);
    
    
    self.tableView.rowHeight = 80;
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isLoading) {
        
        return 1;
    } else {
    
    return [friends count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isLoading) {
        return [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
    } else {
    
    FriendCell *cell = (FriendCell *)[tableView dequeueReusableCellWithIdentifier:FriendCellIdentifier];
   
    
    Friend *friend = [friends objectAtIndex:indexPath.row];
    
    cell.friendTagLabel.text = friend.friendTag;
    cell.friendScoreLabel.text = [NSString stringWithFormat:@"%@", friend.friendScore];
    [cell configureForSearchResults:friend];
    
    return cell;
    }  
}

- (NSURL *)urlWithSearchText:(NSString *)searchText {
    
    NSString *escapedSearch = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *search = [NSString stringWithFormat:@"http://www.xboxleaders.com/api/friends.json?gamertag=%@&region=en-US", escapedSearch];
    NSURL *url = [NSURL URLWithString:search];
    return url;
}

- (void)performSearch:(NSString *)text {

    isLoading = YES;
    [self.searchBar resignFirstResponder];
    
    friends = [NSMutableArray arrayWithCapacity:20];
    
    NSURL *url = [self urlWithSearchText:text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                        JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             
                                             //NSLog(@"TableView Success");
                                             //NSLog(@"%@", JSON);
                                             
                                             NSDictionary *dictionary = [JSON objectForKey:@"data"];
                                             NSArray *array = [dictionary objectForKey:@"friends"];
                                             
                                             for (NSDictionary *resultDict in array) {
                                                 
                                                 Friend *friend = [[Friend alloc] init];
                                                friend.friendTag = [resultDict objectForKey:@"gamertag"];
                                                 friend.friendScore = [resultDict objectForKey:@"gamerscore"];
                                                 NSDictionary *gamerPic = [resultDict objectForKey:@"gamerpic"];
                                                 friend.avatarImage = [gamerPic objectForKey:@"small"];
                                                 friend.avatarLargeImage = [gamerPic objectForKey:@"large"];
                                                 friend.onlineStatus = [resultDict objectForKey:@"online"];
                                                 friend.gameURL = [resultDict objectForKey:@"status"];

                                                 
                                              
                                                 
                                                 [friends addObject:friend];
                                                 isLoading = NO;
                                                 
                                             }
                                         [self.tableView reloadData];
                                         
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             
                                             NSLog(@"FRIENDS LOAD Fail %@", error);
                                             
                                         }];
    
 
    [queue addOperation:operation];
    [self.tableView reloadData];
        
        
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self performSearch:searchBar.text];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        FriendDetailViewController *friendController = segue.destinationViewController;
        NSIndexPath *path = friendIndexPath;
        friendController.friend = [friends objectAtIndex:path.row];
        
        
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   // FriendDetailViewController *friendController = [[FriendDetailViewController alloc] initWithNibName:@"FriendDetailViewController" bundle:nil];

    friendIndexPath = indexPath;
    
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
    
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    return indexPath;
}








@end
