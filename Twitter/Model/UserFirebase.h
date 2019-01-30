//
//  UserFirebase.h
//  Twitter
//
//  Created by Дмитрий Матвеенко on 30/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserFirebase : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *handle;

-(id) initWithName: (NSString *)nameText handleUser: (NSString *)handleText;

@end

NS_ASSUME_NONNULL_END
