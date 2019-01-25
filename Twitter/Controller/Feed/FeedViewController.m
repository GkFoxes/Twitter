//
//  FirstViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableFeedContent;

@property (nonatomic, strong) NSMutableArray * testArray;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    self.testArray = [[NSMutableArray alloc] initWithObjects:@"AAA", @"BBB", @"CCC", nil];
}

// MARK: - Table View data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"FeedCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString * item = [self.testArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item;
    return cell;
}

@end
