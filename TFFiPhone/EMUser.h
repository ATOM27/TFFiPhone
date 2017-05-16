//
//  EMUser.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 08.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface EMUser : NSObject

@property(assign, nonatomic) NSInteger userID;
@property(strong, nonatomic) NSString* name;
@property(strong, nonatomic) NSString* surname;
@property(strong, nonatomic) NSString* username;
@property(strong, nonatomic) NSString* imageURL;
@property(strong, nonatomic) NSDate* dateOfBirth;
@property(strong, nonatomic) NSString* country;
@property(strong, nonatomic) NSString* city;
@property(strong, nonatomic) NSString* email;
@property(strong, nonatomic) NSString* placeOfWorkOrStudy;
@property(strong, nonatomic) NSString* speciality;
@property(strong, nonatomic) NSString* motivationMessage;

- (instancetype)initWithUserDetail:(NSDictionary*)userDetail andUser:(NSDictionary*)user;
- (instancetype)initWithUserDetail:(NSDictionary*)userDetail;

@end
