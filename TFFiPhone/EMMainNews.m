//
//  EMMainNiews.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 14.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMMainNews.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+replaceHTMLCode.h"

@implementation EMMainNews

-(id) initWithServerResponse:(NSDictionary*) responseObject{
    self = [super init];
    if (self) {
        
        self.postText = [responseObject objectForKey:@"text"];
        self.postText = [self.postText stringByStrippingHTML];
        self.imageURL = [responseObject objectForKey:@"image"];
    }
    return self;
}
    
-(NSString*)replaceStringWithHTMLTags:(NSString*) text{
    text = [text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    text = [text stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
    
    return text;
}
    

    
@end
