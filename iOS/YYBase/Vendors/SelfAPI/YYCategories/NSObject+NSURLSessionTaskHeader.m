//
//  NSURLSessionDataTask+ResponseHeader.m
//  trader-ios
//
//  Created by YYang1 on 2/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "NSObject+NSURLSessionTaskHeader.h"

@implementation NSObject (NSURLSessionTaskHeader)
-(NSDictionary *)getHeaderFields{
    if ([self respondsToSelector:@selector(response)]) {
        id response = [self performSelector:@selector(response)];
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            return ((NSHTTPURLResponse *)response).allHeaderFields;
        }
    }
    return nil;
}
@end
