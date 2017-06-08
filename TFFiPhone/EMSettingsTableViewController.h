//
//  EMSettingsTableViewController.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 26.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMUser.h"

@interface EMSettingsTableViewController : UITableViewController

@property(strong, nonatomic) EMUser* currentUser;

@end
