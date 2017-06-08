//
//  EMUserProfileTableViewController.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMUser.h"

@interface EMUserProfileTableViewController : UITableViewController

@property(strong, nonatomic) EMUser* currentUser;
@property(assign, nonatomic) BOOL isOwner;

@end
