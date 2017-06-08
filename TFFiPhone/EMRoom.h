//
//  EMRoom.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 24.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EMProject.h"

@interface EMRoom : NSObject

@property(strong, nonatomic) NSString* roomName;
@property(strong, nonatomic, nullable) EMProject* project;
@property(strong, nonatomic) EMUser* friendUser;

- (instancetype)initWithResponceObject:(NSDictionary*) responceObject;

@end
