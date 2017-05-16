//
//  EMMembersTableViewCell.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMMembersTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *memberImageView;
@property (strong, nonatomic) IBOutlet UILabel *memberNameSurname;

    
-(void)prepareForReuse;
    
+(NSString*)reuseIdentifier;
    
@end
