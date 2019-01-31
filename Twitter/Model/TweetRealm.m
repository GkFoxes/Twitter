//
//  TweetRealm.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 31/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "TweetRealm.h"

@implementation TweetRealm

- (NSArray *)setTableData {
    
    tableDataRealm = [TweetRealm allObjects];
    NSMutableArray *tableDataArray = [NSMutableArray array];
    
    for (RLMObject *object in tableDataRealm) {
        [tableDataArray addObject:object];
    }
    
    return tableDataArray;
}

-(void)updateDataObject:(TweetRealm*)object text:(NSString*)text{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    object.text = text;
    [realm commitWriteTransaction];
}

-(void)deleteDataObjectAtIndex:(int)index{
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObject:[tableDataRealm objectAtIndex:index]];
    [[RLMRealm defaultRealm] commitWriteTransaction];
    
    tableDataRealm = [TweetRealm allObjects];
 }
@end
