//
//  EMMainNewsCell.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 14.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMNewsCell.h"

@implementation EMNewsCell

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
    
    self.newsImageView.image = nil;
    self.newsTextLabel.text = nil;
}
    
+(NSString*)reuseIdentifier{
    return @"NewsCellIdentifier";
}
    
    

@end
