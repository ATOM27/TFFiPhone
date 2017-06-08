//
//  EMRoom.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 24.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMRoom.h"
#import "EMUser.h"
#import "EMHTTPManager.h"

@implementation EMRoom

- (instancetype)initWithResponceObject:(NSDictionary*) responceObject
{
    self = [super init];
    if (self) {
        
        if(responceObject[@"project"]){
            self.project = responceObject[@"project"];
        }
        EMUser* currentUser = [[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"]] firstObject];
        if(responceObject[@"membersApplyApp"]){
            for(NSDictionary* memb in responceObject[@"membersApplyApp"]){
                if([memb[@"id"] stringValue] != currentUser.userID){
                    self.friendUser = [[EMUser alloc] initWithUserDetail:memb];
                }else
                    continue;
            }
            
            if([responceObject[@"title"] isEqualToString:@"room title"])
                self.roomName = [NSString stringWithFormat:@"%@ %@", self.friendUser.username, self.friendUser.surname];
            else
                self.roomName = responceObject[@"title"];
        }
        
    }
    return self;
}

@end
