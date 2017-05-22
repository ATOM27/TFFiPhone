//
//  EMProjectNewsTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 18.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMProjectNewsTableViewController.h"
#import "EMHTTPManager.h"
#import "UIViewController+Alert.h"
#import "EMProject.h"

@interface EMProjectNewsTableViewController ()

@property(strong, nonatomic) EMProject* project;

@end

@implementation EMProjectNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) refreshWall{
    [[EMHTTPManager sharedManager] getCurrentProjectNewsWithProjectID:self.project.projectID
                                                               offset:0
                                                                limit:25
                                                            onSiccess:^(NSArray *posts) {
                                                                [self.postsArray removeAllObjects];
                                                                [self.postsArray addObjectsFromArray:posts];
                                                                [self.tableView reloadData];
                                                                [self.refreshControl endRefreshing];
                                                            } onFailure:^(NSError *error, NSInteger statusCode) {
                                                                [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                                                [self.refreshControl endRefreshing];
                                                            }];
}

-(void) getNewsFromServer{
    self.project = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentProject"]] firstObject];

    [[EMHTTPManager sharedManager] getCurrentProjectNewsWithProjectID:self.project.projectID
                                                               offset:[self.postsArray count]
                                                                limit:25
                                                            onSiccess:^(NSArray *posts) {
                                                                    [self.postsArray addObjectsFromArray:posts];
                                                                    [self.tableView reloadData];
                                                                }
                                                            onFailure:^(NSError *error, NSInteger statusCode) {
                                                                    [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                                                
                                                                }];
}
     


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
