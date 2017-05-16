//
//  EMCurrentProjectTableViewController.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMProject.h"

@interface EMCurrentProjectTableViewController : UITableViewController

@property(strong, nonatomic) EMProject* project;
    
@end
