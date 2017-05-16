//
//  EMProjectCell.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 15.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMProjectCell.h"

@implementation EMProjectCell

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
    
    self.projectImageView.image = nil;
    self.projectNameLabel.text = nil;
    self.shortDescriptionLabel.text = nil;
}
    
+(NSString*)reuseIdentifier{
    return @"ProjectCellIdentifier";
}

@end
