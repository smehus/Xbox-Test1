//
//  FriendDetailViewController.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/29/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"

@interface FriendDetailViewController ()

@end

@implementation FriendDetailViewController {
    
    NSOperationQueue *queue;
    NSString *mottoString;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    queue = [[NSOperationQueue alloc] init];
    
    NSLog(@"%@", self.friend.friendTag);
    
    self.friendTagLabel.text = self.friend.friendTag;
    [self.friendAvatarImage setImageWithURL:[NSURL URLWithString:self.friend.avatarLargeImage] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
     self.friendScoreLabel.text = [NSString stringWithFormat:@"%@", self.friend.friendScore];
    self.onlineStatusLabel.text = [NSString stringWithFormat:@"%hhd", self.friend.onlineStatus];
    
    NSLog(@"%@", self.friend.gameURL);
    
    [self.gameImageView setImageWithURL:[NSURL URLWithString:self.friend.gameURL] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    [self performSearch];
  
    
    self.mottoLabel.text = @"";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabels {
    
    self.mottoLabel.text = [NSString stringWithFormat:@"'%@'", mottoString];
    
    
}

- (NSURL *)urlWithSearchText:(NSString *)text {
    
    NSString *escapedString = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *searchString = [NSString stringWithFormat:@"http://www.xboxleaders.com/api/profile.json?gamertag=%@&region=en-US", escapedString];
    NSURL *url = [NSURL URLWithString:searchString];
    return url;
}

- (void)performSearch {
    
    NSURL *url = [self urlWithSearchText:self.friend.friendTag];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                    JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                        NSLog(@"Friend Detail Succes");
                        NSLog(@"%@", JSON);
                        
                        NSDictionary *dictionary = [JSON objectForKey:@"Data"];
                        mottoString = [dictionary objectForKey:@"Motto"];
                        
                        [self updateLabels];
                        
                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                        NSLog(@"Friend Detail Failure");
                    }];
    
   
    [queue addOperation:operation];
    
}

@end
