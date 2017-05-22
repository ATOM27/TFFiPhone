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
        self.userID = [userDetail[@"id"] stringValue];
        self.name = userDetail[@"name"];
        self.surname = userDetail[@"surname"];
        self.username = user[@"username"];
        if(![userDetail[@"image"] isKindOfClass:[NSNull class]]){
            self.imageURL = userDetail[@"image"];
        }
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        self.dateOfBirth = [dateFormatter dateFromString:userDetail[@"dateOfBirth"]];
        if([userDetail[@"gender"] isEqualToString:@"m"]){
            self.gender = @"Male";
        }else{
            self.gender = @"Female";
        }
        
        self.country = userDetail[@"country"];
        self.city = userDetail[@"city"];
        self.email = user[@"email"];
        self.placeOfWorkOrStudy = userDetail[@"placeOfWorkOrStudy"];
        self.speciality = userDetail[@"speciality"];
        self.motivationMessage = userDetail[@"motivationMessage"];
        self.faceBookLink = userDetail[@"faceBookLink"];
            self.skypeLink = userDetail[@"skypeLink"];
            self.telegrammLink = userDetail[@"telegrammLink"];
            self.googlePlusLink = userDetail[@"googlePlusLink"];
            self.instagrammLink = userDetail[@"instagrammLink"];
            self.twitterLink = userDetail[@"twitterLink"];
            self.behanceLink = userDetail[@"behanceLink"];
            self.linkedInLink = userDetail[@"linkedInLink"];
    }
    return self;
}
    
- (instancetype)initWithUserDetail:(NSDictionary*)userDetail{
    self = [super init];
    if (self) {
        self.userID = [userDetail[@"id"] stringValue];
        self.name = userDetail[@"name"];
        self.surname = userDetail[@"surname"];
        self.username = userDetail[@"name"];
        if(![userDetail[@"image"] isKindOfClass:[NSNull class]]){
            self.imageURL = userDetail[@"image"];
        }
        
        if([userDetail[@"gender"] isEqualToString:@"m"]){
            self.gender = @"Male";
        }else{
            self.gender = @"Female";
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
            self.faceBookLink = userDetail[@"faceBookLink"];
            self.skypeLink = userDetail[@"skypeLink"];
            self.telegrammLink = userDetail[@"telegrammLink"];
            self.googlePlusLink = userDetail[@"googlePlusLink"];
            self.instagrammLink = userDetail[@"instagrammLink"];
            self.twitterLink = userDetail[@"twitterLink"];
            self.behanceLink = userDetail[@"behanceLink"];
            self.linkedInLink = userDetail[@"linkedInLink"];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.surname = [aDecoder decodeObjectForKey:@"surname"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.imageURL = [aDecoder decodeObjectForKey:@"image"];
        self.dateOfBirth = [aDecoder decodeObjectForKey:@"dateOfBirth"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.placeOfWorkOrStudy = [aDecoder decodeObjectForKey:@"placeOfWorkOrStudy"];
        self.speciality = [aDecoder decodeObjectForKey:@"speciality"];
        self.motivationMessage = [aDecoder decodeObjectForKey:@"motivationMessage"];
        self.faceBookLink = [aDecoder decodeObjectForKey:@"faceBookLink"];
        self.skypeLink = [aDecoder decodeObjectForKey:@"skypeLink"];
        self.telegrammLink = [aDecoder decodeObjectForKey:@"telegrammLink"];
        self.googlePlusLink = [aDecoder decodeObjectForKey:@"googlePlusLink"];
        self.instagrammLink = [aDecoder decodeObjectForKey:@"instagrammLink"];
        self.twitterLink = [aDecoder decodeObjectForKey:@"twitterLink"];
        self.behanceLink = [aDecoder decodeObjectForKey:@"behanceLink"];
        self.linkedInLink = [aDecoder decodeObjectForKey:@"linkedInLink"];
}
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.surname forKey:@"surname"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.imageURL forKey:@"image"];
    [aCoder encodeObject:self.dateOfBirth forKey:@"dateOfBirth"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.placeOfWorkOrStudy forKey:@"placeOfWorkOrStudy"];
    [aCoder encodeObject:self.speciality forKey:@"speciality"];
    [aCoder encodeObject:self.motivationMessage forKey:@"motivationMessage"];
    [aCoder encodeObject:self.faceBookLink forKey:@"faceBookLink"];
    [aCoder encodeObject:self.skypeLink forKey:@"skypeLink"];
    [aCoder encodeObject:self.telegrammLink forKey:@"telegrammLink"];
    [aCoder encodeObject:self.googlePlusLink forKey:@"googlePlusLink"];
    [aCoder encodeObject:self.instagrammLink forKey:@"instagrammLink"];
    [aCoder encodeObject:self.twitterLink forKey:@"twitterLink"];
    [aCoder encodeObject:self.behanceLink forKey:@"behanceLink"];
    [aCoder encodeObject:self.linkedInLink forKey:@"linkedInLink"];
    [aCoder encodeObject:self.faceBookLink forKey:@"faceBookLink"];
    [aCoder encodeObject:self.skypeLink forKey:@"skypeLink"];
    [aCoder encodeObject:self.telegrammLink forKey:@"telegrammLink"];
    [aCoder encodeObject:self.googlePlusLink forKey:@"googlePlusLink"];
    [aCoder encodeObject:self.instagrammLink forKey:@"instagrammLink"];
    [aCoder encodeObject:self.twitterLink forKey:@"twitterLink"];
    [aCoder encodeObject:self.behanceLink forKey:@"behanceLink"];
    [aCoder encodeObject:self.linkedInLink forKey:@"linkedInLink"];

}

@end
