//
//  NSString+replaceHTMLCode.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 15.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "NSString+replaceHTMLCode.h"

@implementation NSString (replaceHTMLCode)

-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];

    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    s = [s stringByReplacingCharactersInRange:r withString:@""];
    while ((r = [s rangeOfString:@"&nbsp;"]).location != NSNotFound)
    s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    //s = [s stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return s;
}
    
@end
