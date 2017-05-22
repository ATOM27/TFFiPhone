//
//  EMCurrentProjectTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMCurrentProjectTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "EMProjectMembersTableViewController.h"

@interface EMCurrentProjectTableViewController ()

@property (strong, nonatomic) IBOutlet UILabel *projectNameTextLabel;
@property (strong, nonatomic) IBOutlet UIImageView *projectImageView;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIImageView *mentorImageView;
@property (strong, nonatomic) IBOutlet UILabel *mentorNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UITextView *mentorDescription;

    
@end

@implementation EMCurrentProjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.project.projectName;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    
    self.projectNameTextLabel.text = self.project.projectName;
    
    NSURL* imageURL = [NSURL URLWithString:self.project.imageURL];
    [self.projectImageView setImageWithURL:imageURL];
    
    self.descriptionTextView.text = self.project.descriptionText;
    
    NSURL* mentorImageURL = [NSURL URLWithString:self.project.mentorImageURL];
    [self.mentorImageView setImageWithURL:mentorImageURL];
    
    self.mentorNameLabel.text = self.project.mentor.username;
    [self.emailButton setTitle:self.project.mentor.email forState:UIControlStateNormal];
    self.mentorDescription.text = self.project.mentorDescriptionText;
}

-(void)viewDidLayoutSubviews{
    self.mentorImageView.layer.cornerRadius = CGRectGetWidth(self.mentorImageView.frame)/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}
    
#pragma mark - UITableViewDataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 3){
        [self performSegueWithIdentifier:@"ProjectMembersIdentifier" sender:self];
    }
}

#pragma mark - Help Methods
    
-(CGSize) sizeForLabel:(UILabel*) label{
    return [label.text sizeWithFont:label.font
                  constrainedToSize:label.frame.size
                      lineBreakMode:NSLineBreakByWordWrapping];

}
-(CGSize) sizeForTextView:(UITextView*) label{
    return [label.text sizeWithFont:label.font
                  constrainedToSize:label.frame.size
                      lineBreakMode:NSLineBreakByWordWrapping];
    
}

#pragma mark - Actions

- (IBAction)emailTouched:(UIButton *)sender {
    NSString* urlString = [NSString stringWithFormat:@"mailto:%@", sender.currentTitle];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
}

    
#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ProjectMembersIdentifier"]){
        EMProjectMembersTableViewController* vc = segue.destinationViewController;
        vc.project = self.project;
    }
}
    

@end
