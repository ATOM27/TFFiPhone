//
//  EMSettingsTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 26.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMSettingsTableViewController.h"
#import "UIViewController+Alert.h"
#import "EMHTTPManager.h"

@interface EMSettingsTableViewController ()
@property (strong, nonatomic) IBOutlet UITextField *countryTextField;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *placeOfWorkTextField;
@property (strong, nonatomic) IBOutlet UITextField *specialityTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *facebookTextField;
@property (strong, nonatomic) IBOutlet UITextField *skypeNickNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *telegramTextField;
@property (strong, nonatomic) IBOutlet UITextField *googlePlusTextField;
@property (strong, nonatomic) IBOutlet UITextField *instagramTextField;
@property (strong, nonatomic) IBOutlet UITextField *twitterTextField;
@property (strong, nonatomic) IBOutlet UITextField *behanceTextField;
@property (strong, nonatomic) IBOutlet UITextField *linkedInTextField;


@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *settingsSetxFields;


@end

@implementation EMSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countryTextField.text = self.currentUser.country;
    self.cityTextField.text = self.currentUser.city;
    self.emailTextField.text = self.currentUser.email;
    self.placeOfWorkTextField.text = self.currentUser.placeOfWorkOrStudy;
    self.specialityTextField.text = self.currentUser.speciality;
    
    self.facebookTextField.text = self.currentUser.faceBookLink;
    self.skypeNickNameTextField.text = self.currentUser.skypeLink;
    self.telegramTextField.text = self.currentUser.telegrammLink;
    self.googlePlusTextField.text = self.currentUser.googlePlusLink;
    self.instagramTextField.text = self.currentUser.instagrammLink;
    self.twitterTextField.text = self.currentUser.twitterLink;
    self.behanceTextField.text = self.currentUser.behanceLink;
    self.linkedInTextField.text = self.currentUser.linkedInLink;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionSave:(UIBarButtonItem *)sender {
    
    if(![self.passwordTextField.text isEqualToString:@""]){
        if(self.passwordTextField.text.length < 6){
            [self alertWithTitle:@"Password" message:@"Your password should be at least 6 characters."];
            return;
        }
        if(![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]){
            [self alertWithTitle:@"Error" message:@"Your passwords are not equals!"];
            return;
        }
    }
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString* gender;
    if([self.currentUser.gender isEqualToString:@"Male"]){
        gender = @"m";
    }else{
        gender = @"f";
    }
    
    NSDictionary* params = @{@"id": self.currentUser.userID,
                             @"name": self.currentUser.name,
                             @"surname": self.currentUser.surname,
                             @"city": self.cityTextField.text,
                             @"country": self.countryTextField.text,
                             @"gender": gender,
                             @"dateOfBirth": [dateFormatter stringFromDate:self.currentUser.dateOfBirth],
                             @"motivationMessage": self.currentUser.motivationMessage,
                             @"placeOfWorkOrStudy": self.placeOfWorkTextField.text,
                             @"email": self.emailTextField.text,
                             @"image": [NSNull null],
                             @"speciality": self.specialityTextField.text,
                             @"faceBookLink": self.facebookTextField.text,
                             @"skypeLink": self.skypeNickNameTextField.text,
                             @"telegrammLink": self.telegramTextField.text,
                             @"googlePlusLink": self.googlePlusTextField.text,
                             @"instagrammLink": self.googlePlusTextField.text,
                             @"twitterLink": self.twitterTextField.text,
                             @"behanceLink": self.behanceTextField.text,
                             @"linkedInLink": self.linkedInTextField.text};
        
        NSDictionary* paramsForPasssword = @{@"id": self.currentUser.userID,
                                             @"username": self.currentUser.username,
                                             @"password": self.passwordTextField.text,
                                             @"email": self.emailTextField.text,
                                             @"groups": [NSNull null]};
        
        
    [[EMHTTPManager sharedManager] updateUserInfoWithDictionary:params
                                                      OnSiccess:^{
                                                          [[EMHTTPManager sharedManager] updatePasswordWithParamethers:paramsForPasssword OnSiccess:^{
                                                              
                                                          } OnFailure:^(NSError *error, NSInteger statusCode) {
                                                               [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                                          }];
                                                      } OnFailure:^(NSError *error, NSInteger statusCode) {
                                                          [self alertWithTitle:@"Error" message:[error localizedDescription]];
                                                      }];
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag != 15){
        [[self.settingsSetxFields objectAtIndex:textField.tag] becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


@end
