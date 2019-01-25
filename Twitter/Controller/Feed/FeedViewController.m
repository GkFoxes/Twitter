//
//  FirstViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedTableViewCell.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableFeedContent;

@property (nonatomic, strong) NSMutableArray * testUsernameArray;
@property (nonatomic, strong) NSMutableArray * testTextArray;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testUsernameArray = [[NSMutableArray alloc] initWithObjects:@"GkFoxes", @"Some Name", @"BLA-BLA", nil];
    self.testTextArray = [[NSMutableArray alloc] initWithObjects:@"Hello World!", @"Some text, text, Some text, text, Some text, text", @"MORE MORE BLA_BLA MORE MORE BLA_BLA MORE MORE BLA_BLA MORE MORE BLA_BLA MORE MORE BLA_BLA MORE MORE BLA_BLA MORE MORE BLA_BLA MORE MORE BLA_BLA", nil];
}

- (void) viewWillAppear:(BOOL)animated {
}

// MARK: - Table View data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.testUsernameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"FeedCell";
    
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString * testUsername = [self.testUsernameArray objectAtIndex:indexPath.row];
    NSString * testText = [self.testTextArray objectAtIndex:indexPath.row];
    
    cell.usernameLabel.text = testUsername;
    cell.textLabel.text = testText;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
