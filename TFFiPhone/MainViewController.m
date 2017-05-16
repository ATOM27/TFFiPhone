//
//  MainViewController.m
//  LGSideMenuControllerDemo
//

#import "MainViewController.h"
#import "LeftViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(void)loadView{
    [super loadView];
    
    self.leftViewController = [LeftViewController new];
    self.leftViewWidth = 250.0;
    //self.leftViewBackgroundImage = [UIImage imageNamed:@"imageLeft"];
    //self.leftViewBackgroundColor = [UIColor colorWithRed:0.5 green:0.65 blue:0.5 alpha:0.95];
    self.rootViewCoverColorForLeftView = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.05];
    UIBlurEffectStyle regularStyle;
    
    if (UIDevice.currentDevice.systemVersion.floatValue >= 10.0) {
        regularStyle = UIBlurEffectStyleRegular;
    }
    else {
        regularStyle = UIBlurEffectStyleLight;
    }
    
    self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;

}

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];

    if (!self.isLeftViewStatusBarHidden) {
        self.leftView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
    }
}


- (BOOL)isLeftViewStatusBarHidden {

    return super.isLeftViewStatusBarHidden;
}


- (void)dealloc {
    NSLog(@"MainViewController deallocated");
}

@end
