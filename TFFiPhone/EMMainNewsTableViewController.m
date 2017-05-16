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
#import "EMMainNewsCell.h"
#import "UIImageView+AFNetworking.h"
#import "EMMainNews.h"

@interface EMMainNewsTableViewController ()

@property(strong, nonatomic) NSMutableArray* postsArray;
    
@end

@implementation EMMainNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postsArray = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;

    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self getNewsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.postsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EMMainNews* post = [self.postsArray objectAtIndex:indexPath.section];
    EMMainNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[EMMainNewsCell reuseIdentifier] forIndexPath:indexPath];
    
    NSURL* url = [NSURL URLWithString:post.imageURL];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    
    __weak EMMainNewsCell* wCell = cell;
    __weak EMMainNewsTableViewController* wSelf = self;
    
    cell.newsTextLabel.text = post.postText;

    [cell.newsImageView setImageWithURLRequest:req
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           if(image == nil){
                                               wCell.newsImageHeightConstraint.constant = 0;
                                           }else{
                                               wCell.newsImageHeightConstraint.constant = wCell.newsImageView.frame.size.height;
                                               wCell.newsImageView.image = image;
                                           }
                                       } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                       }];
    
    return cell;
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


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
