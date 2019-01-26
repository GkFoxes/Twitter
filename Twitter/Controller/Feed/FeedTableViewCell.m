//
//  FeedTableViewCell.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 25/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

@synthesize usernameLabel = _usernameLabel;
@synthesize textLabel = _textLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
