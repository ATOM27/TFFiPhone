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
        self.projectID = [responceObject[@"id"] stringValue];
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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.projectID = [aDecoder decodeObjectForKey:@"projectID"];
        self.imageURL = [aDecoder decodeObjectForKey:@"imageURL"];
        self.descriptionText = [aDecoder decodeObjectForKey:@"descriptionText"];
        self.projectName = [aDecoder decodeObjectForKey:@"projectName"];
        self.shortDescriptionText = [aDecoder decodeObjectForKey:@"shortDescriptionText"];
        self.mentor = [aDecoder decodeObjectForKey:@"mentor"];
        self.mentorImageURL = [aDecoder decodeObjectForKey:@"mentorImageURL"];
        self.mentorDescriptionText = [aDecoder decodeObjectForKey:@"mentorDescriptionText"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.projectID forKey:@"projectID"];
    [aCoder encodeObject:self.imageURL forKey:@"imageURL"];
    [aCoder encodeObject:self.descriptionText forKey:@"descriptionText"];
    [aCoder encodeObject:self.projectName forKey:@"projectName"];
    [aCoder encodeObject:self.shortDescriptionText forKey:@"shortDescriptionText"];
    [aCoder encodeObject:self.mentor forKey:@"mentor"];
    [aCoder encodeObject:self.mentorImageURL forKey:@"mentorImageURL"];
    [aCoder encodeObject:self.mentorDescriptionText forKey:@"mentorDescriptionText"];
}

    
@end
