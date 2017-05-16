//
//  EMMembersTableViewCell.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMMembersTableViewCell.h"

@implementation EMMembersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    
-(void)prepareForReuse{
    [super prepareForReuse];
    self.memberImageView.image = nil;
    self.memberNameSurname = nil;
    
}
    
+(NSString*)reuseIdentifier{
    return @"MemberCellIdentifier";
}

@end
