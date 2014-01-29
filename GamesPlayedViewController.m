//
//  GamesPlayedViewController.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/31/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "GamesPlayedViewController.h"
#import "Game.h"
#import "SearchGames.h"
#import "SecondViewController.h"
#import "FriendCell.h"
#import "UIImageView+AFNetworking.h"
#import "GameDetailViewController.h"
#import "GameCell.h"

static NSString *GameCellIdentifier = @"GameCell";
static NSString *LoadingCellIdentifier = @"LoadingCell";

@interface GamesPlayedViewController ()

@end

@implementation GamesPlayedViewController {

    SearchGames *searchGames;
    Game *selectedGame;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
     
        //self.games = [NSMutableArray arrayWithCapacity:20];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:GameCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:GameCellIdentifier];
    
    cellNib = [UINib nibWithNibName:LoadingCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:LoadingCellIdentifier];
    
    
   
    
    self.tableView.rowHeight = 80;
    selectedGame = [[Game alloc] init];
   // NSLog(@"%@", self.games);
   
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     GameCell *cell = (GameCell *)[tableView dequeueReusableCellWithIdentifier:GameCellIdentifier];
    
    Game *game = [self.games objectAtIndex:indexPath.row];

    cell.gameTitleLabel.text = game.gameTitle;
    cell.gameScoreLabel.text = [NSString stringWithFormat:@"%@ G", game.earnedGameScore];
    [cell.boxArtImageView setImageWithURL:[NSURL URLWithString:game.gameLargeBoxArt] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"GameDetail"]) {
        
        GameDetailViewController *controller = segue.destinationViewController;
        controller.game = selectedGame;
        controller.searchGameTag = self.gamerTag;
        
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedGame = [self.games objectAtIndex:indexPath.row];
  
    [self performSegueWithIdentifier:@"GameDetail" sender:nil];
}

- (void)updateViewController {
    
    [self.games removeAllObjects];
    [self.tableView reloadData];
}

@end
