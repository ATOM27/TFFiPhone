//
//  EMMainNiews.h
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 14.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EMNews : NSObject

@property(strong, nonatomic) NSString* imageURL;
@property(strong, nonatomic) NSString* postText;

-(id) initWithServerResponse:(NSDictionary*) responseObject;
-(NSString*) shortTextDescription;


@end
