//
//  Globler.m
//  TestStoryboard
//
//  Created by shareach on 13-6-26.
//  Copyright (c) 2013年 shareach. All rights reserved.
//

#import "KeychainUtil.h"
#import "BCCKeychain.h"

#define KeychainServer  @"LoveMarket.login"
@implementation KeychainUtil


/********************登录账号缓存*********************************/
//保存用户名密码的钥匙串
+ (BOOL)saveKeyChainWithUserName:(NSString *)userName andPd:(NSString *)pd
{
    return [BCCKeychain storeUsername:userName andPasswordString:pd forServiceName:KeychainServer updateExisting:YES error:nil];
}

//删除用户名对应的密码
+ (BOOL)delKeyChainWithUserName:(NSString *)userName
{
    return  [BCCKeychain deleteItemForUsername:userName andServiceName:KeychainServer error:nil];
}

//获取用户名对应的密码
+ (NSString *)getKeyChainWithUserName:(NSString *)userName
{
    return [BCCKeychain getPasswordStringForUsername:userName andServiceName:KeychainServer error:nil];
}




@end
