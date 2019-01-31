//
//  TweetRealm.h
//  Twitter
//
//  Created by Дмитрий Матвеенко on 31/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

RLM_ARRAY_TYPE(TweetRealm)

@interface TweetRealm : RLMObject
{
    RLMResults *tableDataRealm;
    TweetRealm *dataObject;
}

@property NSString *name;
@property NSString *text;

- (NSArray *) setTableData;
-(void)updateDataObject:(TweetRealm*)object text:(NSString*)text;

@end
