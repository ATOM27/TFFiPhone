//
//  EMMainNewsCell.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 14.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMNewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UILabel *newsTextLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *newsImageHeightConstraint;

-(void)prepareForReuse;
    
+(NSString*)reuseIdentifier;

@end
