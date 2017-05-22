//
//  EMMainNewsTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 14.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMMainNewsTableViewController.h"
#import "EMHTTPManager.h"
#import "UIViewController+Alert.h"
#import "EMNewsCell.h"
#import "UIImageView+AFNetworking.h"
#import "EMNews.h"

@interface EMMainNewsTableViewController ()

    
@end

@implementation EMMainNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    

#pragma mark - Table view data source





#pragma mark - Help Methods
    
-(void) refreshWall{
    [[EMHTTPManager sharedManager] getNewsWithOffset:0
                                               limit:25
                                           onSiccess:^(NSArray *posts) {
                                               [self.postsArray removeAllObjects];
                                               [self.postsArray addObjectsFromArray:posts];
                                               [self.tableView reloadData];
                                               [self.refreshControl endRefreshing];
                                           }
                                           onFailure:^(NSError *error, NSInteger statusCode) {
                                               [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                               [self.refreshControl endRefreshing];
                                           }];
}
    
-(void) getNewsFromServer{
    [[EMHTTPManager sharedManager] getNewsWithOffset:[self.postsArray count]
                                               limit:25
                                           onSiccess:^(NSArray *posts) {
                                               [self.postsArray addObjectsFromArray:posts];
                                               [self.tableView reloadData];
                                           }
                                           onFailure:^(NSError *error, NSInteger statusCode) {
                                               [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                           }];
}
    

@end
