//
//  EMHTTPManager.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 08.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMUser.h"

@interface EMHTTPManager : NSObject

+ (EMHTTPManager *)sharedManager;

-(void)loginWithName:(NSString*)name password:(NSString*)password onSuccess:(void(^)(EMUser* user))success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void) getNewsWithOffset:(NSInteger) offset limit:(NSInteger) limit onSiccess:(void(^)(NSArray* posts)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void) getAllProjectsOnSiccess:(void(^)(NSArray* projects)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void) getAllMembersWithProjectID:(NSString*) projectID onSiccess:(void(^)(NSArray* members)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void) getCurrentProjectNewsWithProjectID:(NSString*)projectID offset:(NSInteger) offset limit:(NSInteger) limit onSiccess:(void(^)(NSArray* posts)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
//-(void) getUserDetailWithUserID:(NSString*)userID OnSiccess:(void(^)(EMUser* user)) success OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void) getRoomsForCurrentUserOnSiccess:(void(^)(NSArray* rooms)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void) authMobileOnSiccess:(void(^)(void)) success OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void)updateUserInfoWithDictionary:(NSDictionary*)params OnSiccess:(void(^)(void)) success OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
-(void)updatePasswordWithParamethers:(NSDictionary*) params OnSiccess:(void(^)(void)) success OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end
