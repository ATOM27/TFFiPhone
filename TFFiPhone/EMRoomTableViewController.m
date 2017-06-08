//
//  EMRoomTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 24.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMRoomTableViewController.h"
#import "EMHTTPManager.h"
#import "UIViewController+Alert.h"
#import "EMMembersTableViewCell.h"
#import "EMRoom.h"
#import "UIImageView+AFNetworking.h"
#import "EMChatWebViewController.h"

@interface EMRoomTableViewController ()

@property(strong, nonatomic) NSArray* roomsArray;
@property(strong, nonatomic) EMRoom* selectedRoom;

@end

@implementation EMRoomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;

    
    [self refreshWall];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Help methods

-(void) refreshWall{
    [[EMHTTPManager sharedManager] getRoomsForCurrentUserOnSiccess:^(NSArray *rooms) {
        self.roomsArray = rooms;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self alertWithTitle:@"Error" message:[error localizedDescription]];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.roomsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EMMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EMMembersTableViewCell reuseIdentifier] forIndexPath:indexPath];
    EMRoom* currentRoom = [self.roomsArray objectAtIndex:indexPath.row];
    cell.memberNameSurname.text = currentRoom.roomName;
    
    if(currentRoom.friendUser.imageURL){
        NSURL* memberImageURL = [NSURL URLWithString:currentRoom.friendUser.imageURL];
        [cell.memberImageView setImageWithURL:memberImageURL];
    }else{
        cell.memberImageView.image = [UIImage imageNamed:@"user-2"];
    }
    cell.memberImageView.layer.cornerRadius = CGRectGetWidth(cell.memberImageView.frame)/2;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedRoom = [self.roomsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"MessageIdentifier" sender:self];
    
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MessageIdentifier"]){
        EMChatWebViewController* vc = segue.destinationViewController;
        vc.request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8000/chat/room/%@/",self.selectedRoom.friendUser.userID]]];
    }
}

@end
