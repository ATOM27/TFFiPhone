//
//  EMProject.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 15.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMUser.h"

@interface EMProject : NSObject

@property(strong, nonatomic) NSString* projectID;
@property(strong, nonatomic) NSString* imageURL;
@property(strong, nonatomic) NSString* projectName;
@property(strong, nonatomic) NSString* descriptionText;
@property(strong, nonatomic) NSString* shortDescriptionText;
@property(strong, nonatomic) EMUser* mentor;
@property(strong, nonatomic) NSString* mentorImageURL;
@property(strong, nonatomic) NSString* mentorDescriptionText;

    
- (instancetype)initWithResponceObject:(NSDictionary*)responceObject;

@end
