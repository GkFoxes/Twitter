//
//  FeedTableViewCell.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 25/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize textLabel = _textLabel;
@synthesize handleLabel = _handleLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//
//- (void)configure:(NSString*)profileImage name:(NSString*)name handle:(NSString*)handle tweet:(NSString*)tweet {
//
//    _nameLabel.text = name;
//    NSString *handleStr = @"@";
//    handleStr = [handleStr stringByAppendingString:handle];
//    _handleLabel.text = handleStr;
//    _textLabel.text = tweet;
//
//    if (profileImage != nil) {
//        NSString *profileStr = [NSString stringWithFormat: @"%@",profileImage];
//        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: profileStr]];
//        self.profileImage.image = [UIImage imageWithData: imageData];
//    }
//}

@end
