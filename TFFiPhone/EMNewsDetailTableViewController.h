//
//  EMNewsDetailTableViewController.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 25.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMNews.h"

@interface EMNewsDetailTableViewController : UITableViewController

@property(strong, nonatomic) EMNews* currentNews;

@end
