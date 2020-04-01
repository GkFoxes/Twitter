//
//  TweetFirebase.h
//  Twitter
//
//  Created by Дмитрий Матвеенко on 29/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetFirebase : NSObject

@property (nonatomic) NSString *text;
@property (nonatomic) NSString *timestamp;

-(id) initWithText: (NSString *)tweetText timestamp: (NSString *)tweetTimestamp;

@end

NS_ASSUME_NONNULL_END
