//
//  UserFirebase.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 30/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "UserFirebase.h"

@implementation UserFirebase

-(id) initWithName: (NSString *)nameText handleUser: (NSString *)handleText {
    if (self = [super init]) {
        self.name = nameText;
        self.handle = handleText;
    }
    return self;
}

@end
