//
//  EMHTTPManager.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 08.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMHTTPManager.h"
#import "AFHTTPSessionManager.h"
#import "EMNews.h"
#import "EMProject.h"
#import "EMUser.h"
#import "EMRoom.h"

@interface EMHTTPManager()

@property (strong,nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation EMHTTPManager

+ (EMHTTPManager *)sharedManager {
    static EMHTTPManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EMHTTPManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"http://127.0.0.1:8000/api/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

-(void)loginWithName:(NSString*)name
            password:(NSString*)password
           onSuccess:(void(^)(EMUser* user))success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSString* URLString = @"api-token-auth/";
    
    NSDictionary* paramethers = @{@"username": name,
                                  @"password": password};
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [self.sessionManager POST:URLString
            parameters:paramethers
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   NSString* tokenString = [NSString stringWithFormat:@"Token %@", [responseObject objectForKey:@"token"]];
                   [[NSUserDefaults standardUserDefaults] setObject:tokenString forKey:@"token"];
                   [[NSUserDefaults standardUserDefaults] synchronize];

                   if(success){
                       
                       EMUser* currentUser = [[EMUser alloc] initWithUserDetail:responseObject[@"userdetail"] andUser:responseObject[@"user"]];
                       
                       [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:@[currentUser]] forKey:@"currentUser"];
                       EMProject* currentProject = [[EMProject alloc] initWithResponceObject:responseObject[@"userproject"]];
                       [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:@[currentProject]] forKey:@"currentProject"];
                       [[NSUserDefaults standardUserDefaults] synchronize];
                       
                       
                       success(currentUser);
                       
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   
                   if(failure){

                       NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                       failure(error, r.statusCode);
                   }
               }];
    
    
    
}
    
-(void) getNewsWithOffset:(NSInteger) offset
                    limit:(NSInteger) limit
                onSiccess:(void(^)(NSArray* posts)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSString* URLString = @"news/";
    
    NSDictionary* paramethers = @{@"offset": @(offset),
                                  @"limit": @(limit)};
    
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager GET:URLString
                  parameters:paramethers
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSArray* postNews = [responseObject objectForKey:@"results"];
                         NSMutableArray *objectsArray = [[NSMutableArray alloc] init];
                         
                         for(NSDictionary* dict in postNews){
                             EMNews* mainNews = [[EMNews alloc] initWithServerResponse:dict];
                             [objectsArray addObject:mainNews];
                         }
                         
                         if(success){
                             success(objectsArray);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                             
                         }
                     }];
}
    
-(void) getAllProjectsOnSiccess:(void(^)(NSArray* projects)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    NSString* URLString = @"projects/";
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager GET:URLString
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         NSMutableArray* projects = [NSMutableArray new];
                         for(NSDictionary* dict in responseObject){
                             EMProject* project = [[EMProject alloc] initWithResponceObject:dict];
                             [projects addObject:project];
                         }
                         
                         if(success){
                             success(projects);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                             
                         }
                     }];
}
    
-(void) getAllMembersWithProjectID:(NSString*) projectID
                         onSiccess:(void(^)(NSArray* members)) success
                         onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    NSString* URLString = [NSString stringWithFormat:@"project/%@/members/", projectID];
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];

    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];

    [self.sessionManager GET:URLString
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         NSMutableArray* members = [NSMutableArray new];
                         for(NSDictionary* dict in responseObject){
                             EMUser* project = [[EMUser alloc] initWithUserDetail:dict];
                             [members addObject:project];
                         }
                         
                         if(success){
                             success(members);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                             
                         }
                     }];

}

-(void) getCurrentProjectNewsWithProjectID:(NSString*)projectID
                                    offset:(NSInteger) offset
                                     limit:(NSInteger) limit
                                 onSiccess:(void(^)(NSArray* posts)) success
                                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSString* URLString = [NSString stringWithFormat:@"project/%@/projectnews/", projectID];

    
    NSDictionary* paramethers = @{@"offset": @(offset),
                                  @"limit": @(limit)};
    
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager GET:URLString
                  parameters:paramethers
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSArray* postNews = [responseObject objectForKey:@"results"];
                         NSMutableArray *objectsArray = [[NSMutableArray alloc] init];
                         
                         for(NSDictionary* dict in postNews){
                             EMNews* mainNews = [[EMNews alloc] initWithServerResponse:dict];
                             [objectsArray addObject:mainNews];
                         }
                         
                         if(success){
                             success(objectsArray);
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                             
                         }
                     }];
}

-(void) getRoomsForCurrentUserOnSiccess:(void(^)(NSArray* rooms)) success
                              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    NSString* URLString = @"chat/rooms/";
    
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];

    [self.sessionManager GET:URLString
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSMutableArray* rooms = [NSMutableArray new];
                         
                         for(NSDictionary* dict in responseObject){
                             EMRoom* room = [[EMRoom alloc] initWithResponceObject:dict];
                             [rooms addObject:room];
                         }
                         
                         if(success)
                             success(rooms);
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                         }
                     }];
}

//-(void) getUserDetailWithUserID:(NSString*)userID
//                      OnSiccess:(void(^)(EMUser* user)) success
//                      OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
//    
//    NSString* URLString = [NSString stringWithFormat:@"profile/%@/", userID];
//    
//    [self.sessionManager GET:URLString
//                  parameters:nil
//                    progress:nil
//                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                         EMUser* user = [[EMUser alloc] initWithUserDetail:responseObject];
//                         if(success){
//                             success(user);
//                         }
//                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                         if(failure){
//                             
//                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
//                             failure(error, r.statusCode);
//                             
//                         }
//                     }];
//}

-(void) authMobileOnSiccess:(void(^)(void)) success
                  OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    NSString* URLString = @"auth/mobile/";

    NSDictionary* auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth"];
    
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.sessionManager.requestSerializer setValue:auth[@"username"] forHTTPHeaderField:@"username"];
    [self.sessionManager.requestSerializer setValue:auth[@"password"] forHTTPHeaderField:@"password"];


    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    [self.sessionManager POST:URLString
                   parameters:nil
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          if(success){
                              success();
                          }
                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          if(failure){
                              NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                              failure(error, r.statusCode);
                          }
                      }];
}

-(void)updateUserInfoWithDictionary:(NSDictionary*)params OnSiccess:(void(^)(void)) success
                          OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    NSString* URLString = [NSString stringWithFormat:@"profile/%@/", params[@"id"]];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [self.sessionManager PUT:URLString
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         if(success){
                             success();
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                         }
                     }];
}

-(void)updatePasswordWithParamethers:(NSDictionary*) params OnSiccess:(void(^)(void)) success
                      OnFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    NSString* URLString = [NSString stringWithFormat:@"user/%@/", params[@"id"]];
    
    [self.sessionManager PUT:URLString
                  parameters:params
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         if(success){
                             success();
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if(failure){
                             NSHTTPURLResponse* r = (NSHTTPURLResponse*)task.response;
                             failure(error, r.statusCode);
                         }
                     }];
    
    
}

@end
