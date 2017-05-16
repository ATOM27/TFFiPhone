//
//  EMProjectCell.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 15.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMProjectCell : UITableViewCell
    
@property(strong, nonatomic) IBOutlet UIImageView* projectImageView;
@property(strong, nonatomic) IBOutlet UILabel* projectNameLabel;
@property(strong, nonatomic) IBOutlet UILabel* shortDescriptionLabel;

-(void)prepareForReuse;
    
+(NSString*)reuseIdentifier;

@end
