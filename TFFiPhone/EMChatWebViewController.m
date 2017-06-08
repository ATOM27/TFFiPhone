//
//  EMChatWebViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 24.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMChatWebViewController.h"
#import "EMHTTPManager.h"

@interface EMChatWebViewController ()

@property(strong, nonatomic) IBOutlet UIWebView* webView;

@end

@implementation EMChatWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak EMChatWebViewController* wSelf = self;
    
    [[EMHTTPManager sharedManager] authMobileOnSiccess:^{
                                                     [self.webView loadRequest:wSelf.request];
                                                 } OnFailure:^(NSError *error, NSInteger statusCode) {
                                                     
                                                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
