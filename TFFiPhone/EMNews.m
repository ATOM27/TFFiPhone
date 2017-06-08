//
//  EMMainNiews.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 14.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMNews.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+replaceHTMLCode.h"

@implementation EMNews

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

-(NSString*) shortTextDescription{
    NSArray* post = [self.postText componentsSeparatedByString:@" "];
    NSMutableString* returnString = [NSMutableString new];
    for(int i = 0; i < [post count]; i++){
        [returnString appendString:[NSString stringWithFormat:@"%@ ",[post objectAtIndex:i]]];
        if(i == 50)
            break;
    }
    [returnString appendString:@"..."];
    return returnString;
}
    

    
@end
