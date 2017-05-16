//
//  EMUser.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 08.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMUser.h"

@implementation EMUser

- (instancetype)initWithUserDetail:(NSDictionary*)userDetail andUser:(NSDictionary*)user{
    self = [super init];
    if (self) {
        self.userID = [userDetail[@"id"] integerValue];
        self.name = userDetail[@"name"];
        self.surname = userDetail[@"surname"];
        self.username = user[@"username"];
        if(userDetail[@"image"]==NULL){
            self.imageURL = userDetail[@"image"];
        }
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        self.dateOfBirth = [dateFormatter dateFromString:userDetail[@"dateOfBirth"]];
        
        self.country = userDetail[@"country"];
        self.city = userDetail[@"city"];
        self.email = user[@"email"];
        self.placeOfWorkOrStudy = userDetail[@"placeOfWorkOrStudy"];
        self.speciality = userDetail[@"speciality"];
        self.motivationMessage = userDetail[@"motivationMessage"];
    }
    return self;
}
    
- (instancetype)initWithUserDetail:(NSDictionary*)userDetail{
    self = [super init];
    if (self) {
        self.userID = [userDetail[@"id"] integerValue];
        self.name = userDetail[@"name"];
        self.surname = userDetail[@"surname"];
        self.username = userDetail[@"name"];
        if(userDetail[@"image"]==NULL){
            self.imageURL = userDetail[@"image"];
        }
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        self.dateOfBirth = [dateFormatter dateFromString:userDetail[@"dateOfBirth"]];
        
        self.country = userDetail[@"country"];
        self.city = userDetail[@"city"];
        self.email = userDetail[@"email"];
        self.placeOfWorkOrStudy = userDetail[@"placeOfWorkOrStudy"];
        self.speciality = userDetail[@"speciality"];
        self.motivationMessage = userDetail[@"motivationMessage"];
    }
    return self;
}

@end
