//
//  CQCaller.h
//  CQCampusMarketing
//
//  Created by YYang on 16/2/2.
//  Copyright © 2016年 ztesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFNetworking;



@interface HttpCaller : NSObject

+ (void)postAsynWithParams:(NSDictionary *_Nonnull)params method:(NSString *_Nonnull)method success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nonnull  responseObject))success failure:(void (^_Nonnull)(NSURLSessionDataTask *  task, NSDictionary * _Nonnull errorDic))failure;


+(void)getAsynWithParams:(NSDictionary *_Nonnull)params method:(NSString *_Nonnull)method success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure;

+(void)putAsynWithParams:(NSDictionary *_Nonnull )params method:(NSString *_Nonnull)method success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure;

+(void)putAsynWithParams:(NSDictionary *)params method:(NSString *)method names:(NSMutableArray<NSString *> *)names fileNames:(NSMutableArray<NSString *> *)fileNames mimeTypes:(NSMutableArray<NSString *> *)types datas:(NSMutableArray <NSData *>*)datas  progress:(nullable void (^)(NSProgress * _Nonnull upProgress))uProgress success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure;


+(void)patchAsynWithParams:(NSDictionary *_Nonnull)params method:(NSString *_Nonnull)method success:(void (^_Nonnull)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^_Nonnull)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure;


+(void)deleteAsynWithParams:(NSDictionary *)params method:(NSString *)method success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nonnull errorDic))failure;

@end
