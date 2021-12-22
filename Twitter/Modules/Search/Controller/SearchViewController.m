//
//  SecondViewController.m
//  Twitter
//
//  Created by Дмитрий Матвеенко on 24/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "UserFirebase.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *userSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableContent;

@property (strong, nonatomic) FIRUser *user;
@property (strong, nonatomic) FIRDatabaseReference *databaseRef;

@property (nonatomic, strong) NSMutableArray *usersArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTableContent.rowHeight = UITableViewAutomaticDimension;
    self.searchTableContent.estimatedRowHeight = 60;
    self.searchTableContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.userSearchBar.delegate = self;
    
    self.user = [FIRAuth auth].currentUser;
    self.databaseRef = [[FIRDatabase database] reference];
    
    self.usersArray = [[NSMutableArray alloc] initWithCapacity:50];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Cancel Side Menu swipe
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
    [[self.databaseRef child:@"user_profiles"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        [self.usersArray removeAllObjects];
        
        for (FIRDataSnapshot * child in snapshot.children) {
            NSDictionary *savedUsers = [child value];
            NSString *name = [savedUsers objectForKey:@"name"];
            NSString *handle = [savedUsers objectForKey:@"handle"];
            
            UserFirebase *user = [[UserFirebase alloc] initWithName:name handleUser:handle];
            [self.usersArray addObject:user];
        }
        
        [self.searchTableContent reloadData];
    }];
}

// MARK: - Table View data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"SearchCell";
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSInteger userIndexPath = ((self.usersArray.count-1) - indexPath.row);
    UserFirebase *userIndex = [self usersArray][userIndexPath];
    
    cell.nameLabel.text = [userIndex name];
    NSString *handleStr = @"@";
    handleStr = [handleStr stringByAppendingString:[userIndex handle]];
    cell.usernameLabel.text = handleStr;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

// MARK: - SearchBar settings

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)userSearchBar {
    [userSearchBar resignFirstResponder];
}

@end
