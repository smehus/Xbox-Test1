//
//  FriendCell.m
//  Xbox-Test1
//
//  Created by scott mehus on 1/28/13.
//  Copyright (c) 2013 scott mehus. All rights reserved.
//

#import "FriendCell.h"
#import "UIImageView+AFNetworking.h"
#import "Gamer.h"
#import "Friend.h"

@implementation FriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {
    
    UIImage *image = [UIImage imageNamed:@"TableCellGradient"];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = backgroundImage;
    
    UIImage *selectedImage = [UIImage imageNamed:@"SelectedTableCellGradient"];
    UIImageView *selectedBackgroundImage = [[UIImageView alloc] initWithImage:selectedImage];
    self.selectedBackgroundView = selectedBackgroundImage;
}

- (void)configureForSearchResults:(Friend *)pal {
    
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:pal.avatarLargeImage] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
}

@end
