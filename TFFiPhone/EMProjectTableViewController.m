//
//  EMProjectTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 15.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMProjectTableViewController.h"
#import "EMHTTPManager.h"
#import "UIViewController+Alert.h"
#import "EMProjectCell.h"
#import "EMProject.h"
#import "UIImageView+AFNetworking.h"
#import "EMCurrentProjectTableViewController.h"

@interface EMProjectTableViewController ()
    
@property(strong, nonatomic) NSMutableArray* projectsArray;
@property(strong, nonatomic) EMProject* selectedProject;

@end

@implementation EMProjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.projectsArray = [[NSMutableArray alloc] init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    [self getProjectsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.projectsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
    

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EMProject* currentProject = [self.projectsArray objectAtIndex:indexPath.section];
    
    EMProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:[EMProjectCell reuseIdentifier] forIndexPath:indexPath];
    
    cell.projectNameLabel.text = currentProject.projectName;
    cell.shortDescriptionLabel.text = currentProject.shortDescriptionText;
    
    NSURL* imageURL = [NSURL URLWithString:currentProject.imageURL];
    NSURLRequest* req = [NSURLRequest requestWithURL:imageURL];
    
    __weak EMProjectCell* wCell = cell;
    
    [cell.projectImageView setImageWithURLRequest:req
                                 placeholderImage:nil
                                          success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                              wCell.projectImageView.image = image;
                                          } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                              
                                          }];
    
    return cell;
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedProject = [self.projectsArray objectAtIndex:indexPath.section];
    [self performSegueWithIdentifier:@"DetailProjectIdentifier" sender:self];
    
}

#pragma mark - Segue
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"DetailProjectIdentifier"]){
        EMCurrentProjectTableViewController* vc = segue.destinationViewController;
        vc.project = self.selectedProject;
    }
}
    
#pragma mark - Help methods
    
-(void) getProjectsFromServer{
    [[EMHTTPManager sharedManager] getAllProjectsOnSiccess:^(NSArray *projects) {
        [self.projectsArray removeAllObjects];
        [self.projectsArray addObjectsFromArray:projects];
        [self.tableView reloadData];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self alertWithTitle:@"Error" message:[error localizedDescription]];
    }];
}

@end
