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
#import "TweetFirebase.h"

@interface FeedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableFeedContent;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) FIRUser *user;
@property (strong, nonatomic) FIRDatabaseReference *databaseRef;
@property (nonatomic) FIRDataSnapshot *userData;

@property (nonatomic, strong) NSMutableArray *tweets;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableFeedContent.rowHeight = UITableViewAutomaticDimension;
    self.tableFeedContent.estimatedRowHeight = 86.0;
    self.tableFeedContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.user = [FIRAuth auth].currentUser;
    self.databaseRef = [[FIRDatabase database] reference];
    
    self.tweets = [[NSMutableArray alloc] initWithCapacity:50];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Add Side Menu swipe
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    
    NSString *uid = [FIRAuth auth].currentUser.uid;
    NSString *uidTweets = [NSString stringWithFormat: @"tweets/%@",uid];
    [[[self.databaseRef child:@"user_profiles"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        //Get all tweets to Feed
        self.userData = snapshot;
        
        [[self.databaseRef child:uidTweets] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            [self.tweets removeAllObjects];
            
            for (FIRDataSnapshot * child in snapshot.children) {
                NSDictionary *savedTweet = [child value];
                NSString *text = [savedTweet objectForKey:@"text"];
                NSString *time = [savedTweet objectForKey:@"timestamp"];
                
                TweetFirebase *tweet = [[TweetFirebase alloc] initWithText:text timestamp:time];
                [self.tweets addObject:tweet];
            }
            
            [self.tableFeedContent reloadData];
            [self.activityIndicator stopAnimating];
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
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
       
        NSInteger tweetIndexPath = ((self.tweets.count-1) - indexPath.row);
        TweetFirebase *tweetIndex = [self tweets][tweetIndexPath];
        
        destViewController.text = [tweetIndex text];
        destViewController.name = self.userData.value[@"name"];
        NSString *handleStr = @"@";
        handleStr = [handleStr stringByAppendingString:self.userData.value[@"handle"]];
        destViewController.username = handleStr;
    }
}

// MARK: - Table View data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"FeedCell";
    
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSInteger tweetIndexPath = ((self.tweets.count-1) - indexPath.row);
    TweetFirebase *tweetIndex = [self tweets][tweetIndexPath];
    
    cell.nameLabel.text = self.userData.value[@"name"];
    NSString *handleStr = @"@";
    handleStr = [handleStr stringByAppendingString:self.userData.value[@"handle"]];
    cell.handleLabel.text = handleStr;
    cell.textLabel.text = [tweetIndex text];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
