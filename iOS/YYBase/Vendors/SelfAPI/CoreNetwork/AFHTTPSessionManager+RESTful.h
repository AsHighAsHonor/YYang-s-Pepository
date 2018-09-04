//
//  AFHTTPSessionManager+RESTful.h
//  trader-ios
//
//  Created by YYang1 on 7/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (RESTful)
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(nullable void (^)(NSProgress * _Nonnull upProgress))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
