//
//  EMLoginViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 08.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMLoginViewController.h"
#import "UIViewController+Alert.h"
#import "EMHTTPManager.h"
#import "EMUser.h"
#import "MainViewController.h"
#import "UIViewController+Alert.h"

@interface EMLoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation EMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.nameTextField]){
        [self.passwordTextField becomeFirstResponder];
    }else if ([textField isEqual:self.passwordTextField]){
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Actions

- (IBAction)actionLogin:(UIButton *)sender {
    if(![self.nameTextField hasText]){
        
        [self alertWithTitle:@"Error!" message:@"You should enter your name"];
        return;
    }
    if(![self.passwordTextField hasText]){
        
        [self alertWithTitle:@"Error!" message:@"You should enter your password"];
        return;
    }
    
    [[EMHTTPManager sharedManager] loginWithName:self.nameTextField.text
                                        password:self.passwordTextField.text
                                       onSuccess:^(EMUser *user) {
                                           [self performSegueWithIdentifier:@"MainViewControllerIdentifier" sender:self];
                                       } onFailure:^(NSError *error, NSInteger statusCode) {
                                           NSLog(@"Error =%@ code = %ld",[error localizedDescription], (long)statusCode);
                                           [self alertWithTitle:@"Error!" message:[error localizedDescription]];
                                       }];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MainViewControllerIdentifier"]){
        
    }
}


@end
