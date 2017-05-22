//
//  EMProjectMembersTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMProjectMembersTableViewController.h"
#import "EMHTTPManager.h"
#import "UIViewController+Alert.h"
#import "EMMembersTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "EMUserProfileTableViewController.h"

@interface EMProjectMembersTableViewController ()
    
@property(strong, nonatomic) NSArray* membersArray;
@property(strong, nonatomic) EMUser* selectedUser;

@end

@implementation EMProjectMembersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[EMHTTPManager sharedManager] getAllMembersWithProjectID:self.project.projectID
                                                    onSiccess:^(NSArray *members) {
                                                        self.membersArray = members;
                                                        [self.tableView reloadData];
                                                    } onFailure:^(NSError *error, NSInteger statusCode) {
                                                        [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                                    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.membersArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EMMembersTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    EMUser* currentUser = [self.membersArray objectAtIndex:indexPath.row];
    
    if(currentUser.imageURL){
        NSURL* memberImageURL = [NSURL URLWithString:currentUser.imageURL];
        [cell.memberImageView setImageWithURL:memberImageURL];
    }else{
        cell.memberImageView.image = [UIImage imageNamed:@"user-2"];
    }
    cell.memberNameSurname.text = [NSString stringWithFormat:@"%@ %@", currentUser.name, currentUser.surname];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedUser = [self.membersArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowMemberProfileIdentifier" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowMemberProfileIdentifier"]){
        EMUserProfileTableViewController* vc = segue.destinationViewController;
        vc.currentUser = self.selectedUser;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
