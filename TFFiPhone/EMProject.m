//
//  EMProject.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 15.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMProject.h"
#import "NSString+replaceHTMLCode.h"

@implementation EMProject

- (instancetype)initWithResponceObject:(NSDictionary*)responceObject
{
    self = [super init];
    if (self) {
        self.projectID = responceObject[@"id"];
        self.imageURL = responceObject[@"image"];
        self.descriptionText = responceObject[@"description"];
        self.descriptionText = [self.descriptionText stringByStrippingHTML];
        self.projectName = responceObject[@"project_name"];
        NSMutableArray* compStr = [self.descriptionText componentsSeparatedByString:@" "];
        NSRange range = NSMakeRange(35, [compStr count] - 35);
        [compStr removeObjectsInRange:range];
        self.shortDescriptionText = [[compStr componentsJoinedByString:@" "] stringByAppendingString:@"..."];
        
        self.mentor = [[EMUser alloc] initWithUserDetail:nil andUser:responceObject[@"mentor_id"]];
        self.mentorImageURL = responceObject[@"mentor_image"];
        self.mentorDescriptionText = responceObject[@"mentor_description"];
        self.mentorDescriptionText = [self.mentorDescriptionText stringByStrippingHTML];
    }
    return self;
}
    
@end
