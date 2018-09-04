//
//  Globler.h
//  TestStoryboard
//
//  Created by shareach on 13-6-26.
//  Copyright (c) 2013年 shareach. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeychainUtil : NSObject

/********************登录账号缓存*********************************/

/**
*  @author YYang, 16-02-08 20:02:53
*
*  保存用户名密码到钥匙串
*
*  @param userName 用户名
*  @param pd 密码
*
*/
+ (BOOL)saveKeyChainWithUserName:(NSString *)userName andPd:(NSString *)pd;
/**
 *  @author YYang, 16-02-08 20:02:33
 *
 *  删除用户名对应的密码
 *
 *  @param userName 用户名
 *
 */
+ (BOOL)delKeyChainWithUserName:(NSString *)userName;
/**
 *  @author YYang, 16-02-08 21:02:18
 *
 *  获取用户名对应的密码
 *
 *  @param userName 用户名
 *
 */
+ (NSString *)getKeyChainWithUserName:(NSString *)userName;





@end




