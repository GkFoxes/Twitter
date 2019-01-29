//
//  TweetFirebase.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 29/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "TweetFirebase.h"

@implementation TweetFirebase

-(id) initWithText: (NSString *)tweetText timestamp: (NSString *)tweetTimestamp {
    if (self = [super init]) {
        self.text = tweetText;
        self.timestamp = tweetTimestamp;
    }
    return self;
}
@end
