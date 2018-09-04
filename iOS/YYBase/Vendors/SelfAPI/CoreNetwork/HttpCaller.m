//
//  CQCaller.m
//  CQCampusMarketing
//
//  Created by YYang on 16/2/2.
//  Copyright © 2016年 ztesoft. All rights reserved.
//

#import "HttpCaller.h"
#import "NSDictionary+JSONString.h"
#import "NSString+Hash.h"
#import "NSString+Time.h"
#import "AFHTTPSessionManager+RESTful.h"


//production => https://gsme.pixelforcesystems.com.au
//staging => https://trader.pixelforcesystems.com.au

//#define TEST_ENV

#ifdef TEST_ENV

#define SERVER_ADDRESS @"http://10.88.2.190:3000/api/v1/"//JJ
//#define SERVER_ADDRESS @"http://10.0.0.73:3000/api/v1/" //YY

#else

#define SERVER_ADDRESS @"https://trader.pixelforcesystems.com.au/api/v1/" // develop
//#define SERVER_ADDRESS @"https://gsme.pixelforcesystems.com.au/api/v1/"  // production

#endif



@implementation HttpCaller
#pragma mark - RESTful Task
+ (void)postAsynWithParams:(NSDictionary *)params method:(NSString *)method success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure {
    
    NSMutableDictionary *param= [self setParamsWithParams:params andMethod:method];
    NSString *paramString = [self objToString:param];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,method];
    
    AFHTTPSessionManager *manager = [self configureSessionManagerWithParamString:paramString];
    
    [manager POST:requestUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successOutput:responseObject url:requestUrl task:task];
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, [self failureOutput:error url:requestUrl]);

    }];
    
}

+(void)getAsynWithParams:(NSDictionary *)params method:(NSString *)method success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure {
    
    NSMutableDictionary *param= [self setParamsWithParams:params andMethod:method];
    NSString *paramString = [self objToString:param];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,method];
    
    AFHTTPSessionManager *manager = [self configureSessionManagerWithParamString:paramString];
    [manager GET:requestUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successOutput:responseObject url:requestUrl task:task];
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, [self failureOutput:error url:requestUrl]);
    }];
}


+(void)putAsynWithParams:(NSDictionary *)params method:(NSString *)method success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure{
    NSMutableDictionary *param= [self setParamsWithParams:params andMethod:method];
    NSString *paramString = [self objToString:param];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,method];
    AFHTTPSessionManager *manager = [self configureSessionManagerWithParamString:paramString];

    [manager PUT:requestUrl parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successOutput:responseObject url:requestUrl task:task];
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, [self failureOutput:error url:requestUrl]);
    }];
}


+(void)putAsynWithParams:(NSDictionary *)params method:(NSString *)method names:(NSMutableArray<NSString *> *)names fileNames:(NSMutableArray<NSString *> *)fileNames mimeTypes:(NSMutableArray<NSString *> *)types datas:(NSMutableArray <NSData *>*)datas  progress:(nullable void (^)(NSProgress * _Nonnull upProgress))uProgress success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure{
    NSAssert(![NSMutableArray isEmptyArray:names], @"names Can not be blank");
    NSAssert(![NSMutableArray isEmptyArray:datas], @"datas Can not be blank");
    NSAssert(![NSMutableArray isEmptyArray:fileNames], @" fileNames Can not be blank");
    NSAssert(![NSMutableArray isEmptyArray:types], @"Can not be blank");
    NSAssert(datas.count == names.count , @"datas / names / fileName 's count not match");
    NSAssert(datas.count == fileNames.count , @"datas / names / fileName 's count not match");

    
    NSMutableDictionary *param= [self setParamsWithParams:params andMethod:method];
    NSString *paramString = [self objToString:param];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,method];
    AFHTTPSessionManager *manager = [self configureSessionManagerWithParamString:paramString];
    [manager PUT:requestUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0 ;i<datas.count ; i++) {
            NSString *realType;
            if (types.count == 1) {
                realType = types.firstObject;
            }else{
                realType = types[i];
            }
             [formData appendPartWithFileData:datas[i] name:names[i] fileName:fileNames[i] mimeType:realType];
        }
    } progress:^(NSProgress * _Nonnull upProgress) {
        uProgress(upProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task, [self failureOutput:error url:requestUrl]);
    }];
    
    
}



+(void)patchAsynWithParams:(NSDictionary *)params method:(NSString *)method success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure{
    NSMutableDictionary *param= [self setParamsWithParams:params andMethod:method];
    NSString *paramString = [self objToString:param];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,method];
    AFHTTPSessionManager *manager = [self configureSessionManagerWithParamString:paramString];
    
    
    [manager PATCH:requestUrl parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successOutput:responseObject url:requestUrl task:task];
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, [self failureOutput:error url:requestUrl]);
    }];
    
}

+(void)deleteAsynWithParams:(NSDictionary *)params method:(NSString *)method success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure{
    NSMutableDictionary *param= [self setParamsWithParams:params andMethod:method];
    NSString *paramString = [self objToString:param];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",SERVER_ADDRESS,method];
    AFHTTPSessionManager *manager = [self configureSessionManagerWithParamString:paramString];
//    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil, nil];

    
    [manager DELETE:requestUrl parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successOutput:responseObject url:requestUrl task:task];
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, [self failureOutput:error url:requestUrl]);
    }];
    
}


+(void)successOutput:(id)responseObject url:(NSString *)requestUrl task:(NSURLSessionTask*)task{
    NSDictionary *headers = [task getHeaderFields];
    NSString *resStr = [self objToString:responseObject];
    NSLog(@"\n REQUEST_URL=====>>>>\n %@ \n RESPONSE =====> \n %@ \n All_HEADER_FIELDS =====>>> \n%@", requestUrl, resStr, headers);
}

+(NSDictionary *)failureOutput:(NSError *)error url:(NSString *)requestUrl{
    [error localizedRecoverySuggestion];
    NSDictionary *userInfo = error.userInfo;
    NSData *errorData = userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    NSDictionary *serializedData;
    if (errorData) {
        serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
    }else{
        serializedData = error.userInfo;
    }
    
    
    NSLog(@"\n REQUEST_URL=====\n %@  \n ERROR =====>\n %@", requestUrl, serializedData);
    return serializedData;
}





#pragma mark - Request Configue
+(void)setHttpRequestParams:(id)req paramString:(NSString *)paramString{
    
    NSString *token = [GVUserDefaults standardUserDefaults].accessToken;
    NSString *userId = [GVUserDefaults standardUserDefaults].userId;
    NSLog(@"X-USER-ACCESS-TOKEN----->>>>>%@",token);
    NSLog(@"X-USER-ID----->>>>>%@",userId);
    
    if (![NSString isBlankString:token]) {
        [req setValue:token forHTTPHeaderField:@"X-USER-ACCESS-TOKEN"];
    }
    if (![NSString isBlankString:userId]) {
        [req setValue:userId forHTTPHeaderField:@"X-USER-ID"];
    }
    
    [req setValue:@"application/json" forHTTPHeaderField:@"content-type"];
}

+(NSMutableDictionary *)setParamsWithParams:(NSDictionary *)params andMethod:(NSString *)method
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:params];
    NSLog(@"METHOD=====>>>> \n %@ \n PARAMS=====>>>> \n %@\n", method, [param JSONString]);
    return param;
}

+(AFHTTPSessionManager*)configureSessionManagerWithParamString:(NSString *)paramString{
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self setHttpRequestParams:sessionManager.requestSerializer paramString:paramString];
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    sessionManager.securityPolicy = securityPolicy;
    
    return sessionManager;
}



#pragma mark - 工具方法
/**
 *  对象转json字符串
 *   obj
 *
 *  @return json字符串
 */
+ (NSString *)objToString:(id)obj{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
    if (! jsonData) {
        NSLog(@"json字符串转换失败: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}



//+(NSString *)generateSignWithTimeString:(NSString *)timeString andParamString:(NSString *)paramString{
//
//    NSString *signString = [NSString stringWithFormat:@"%@%@%@%@%@",kAppSecret,timeString,kAppKey,paramString,kAppSecret];
//    signString = [signString md5String];
//
//    signString = [signString uppercaseString];
//    return signString;
//}

@end
