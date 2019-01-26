//
//  FirstViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedTableViewCell.h"
#import "TwitViewController.h"

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
    
    self.tableFeedContent.rowHeight = UITableViewAutomaticDimension;
    self.tableFeedContent.estimatedRowHeight = 56.0;
    self.tableFeedContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Add Side Menu swipe
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

// MARK: - Button Action

- (IBAction)showSideMenu:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

// MARK: - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showTwit"]) {
        NSIndexPath *indexPath = [self.tableFeedContent indexPathForSelectedRow];
        
        TwitViewController *destViewController = segue.destinationViewController;
        
        destViewController.username = [_testUsernameArray objectAtIndex:indexPath.row];
        destViewController.text = [_testTextArray objectAtIndex:indexPath.row];
    }
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
