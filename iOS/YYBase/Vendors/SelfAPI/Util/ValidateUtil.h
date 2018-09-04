//
//  ValidateUtil.h
//  SalesAssisant
//
//  Created by YYang on 16/1/5.
//  Copyright (c) 2015年 ztesoft. All rights reserved.
//  放一些公用的验证类方法

#import <Foundation/Foundation.h>

@interface ValidateUtil : NSObject

/**
 *  @author YYang, 16-02-08 21:02:55
 *
 *  验证手机号码
 *
 *
 */
+ (BOOL) isPhoneNum: (NSString *)phoneNum ;

#pragma mark 验证是否为空字符串、空格等
+ (BOOL) isEmptyStr: (NSString *)str;

#pragma mark 验证身份证号码
+ (BOOL) isCardNum: (NSString *)cardNum;

#pragma mark 验证手机卡号
+ (BOOL) isCardNo: (NSString *)cardNo;

#pragma mark 验证是否为整形
/**
 *  验证是否为整形
 *
 *  @param str 要校验的字符串
 *
 *  @return 校验结果
 */
+ (BOOL)isPureInt:(NSString *)str;

#pragma mark 验证是否为浮点
/**
 *  验证是否为浮点
 *
 *  @param str 要校验的字符串
 *
 *  @return 校验结果
 */
+ (BOOL)isPureFloat:(NSString *)str;

#pragma mark 验证是否数字
/**
 *  验证是否数字
 *
 *  @param str 要校验的字符串
 *
 *  @return 校验结果
 */
+ (BOOL)isNumber:(NSString *)str;

/**
 *  验证是否正确的电信手机号码
 *
 *  @param phoneNumber 手机号码
 *
 *  @return 校验结果
 */
+ (BOOL)isTelecomNumber:(NSString *)phoneNumber;

/**
 *  是否正确固话
 *
 *  @param ghNumber 四位区号
 *
 *  @return 校验结果
 */
+ (BOOL)isGHNumber:(NSString *)ghNumber;

/**
 *  验证是否正确的人名
 *
 *  @param name 人名
 *
 *  @return 校验结果
 */
+ (BOOL)isSureName:(NSString *)name;

/**
 *  验证是否正确的邮箱地址
 *
 *  @param email 邮箱地址
 *
 *  @return 校验结果
 */
+ (BOOL)isEmail:(NSString *)email;

/**
 *  @author YYang, 16-05-22 18:05:38
 *
 *  1 . 校验密码强度
 密码的强度必须是包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间。
 *
 *  @param pd 密码
 *
 *  @return YES/NO
 */

+ (BOOL)rightPasswordStrength:(NSString *)password;


/**
 *  @author YYang, 16-05-22 18:05:18
 *
 *  2. 校验中文
 字符串仅能是中文。
 *
 *  @param text 文字
 *
 *  @return  YES/NO
 */
+ (BOOL)isChinese:(NSString *)text;

/**
 *  @author YYang, 16-05-22 18:05:02
 *
 *  3. 由数字、26个英文字母或下划线组成的字符串
 *
 *  @param text text
 *
 *  @return YES/NO
 */
+ (BOOL)onlyNumEngUnderLine:(NSString *)text;

/**
 *  @author YYang, 16-05-22 18:05:13
 *
 *  5. 校验身份证号码
 
 身份证号码的正则校验。15 或 18位。严格校验
 *
 *  @param identityCard 身份证
 *
 *  @return
 */
+ (BOOL )verifyIdCardNum:(NSString *)identityCard;

/**
 *  @author YYang, 16-05-22 18:05:57
 *
 *  6. 校验日期
 “yyyy-mm-dd“ 格式的日期校验，已考虑平闰年。
 
 *
 *  @param date 日期
 *
 *  @return
 */
+ (BOOL)correctDate:(NSString *)date;

/**
 *  @author YYang, 16-05-22 18:05:24
 *
 *  7. 校验金额
 金额校验，精确到2位小数。
 
 ^[0-9]+(.[0-9]{2})?$
 *
 *  @param money money
 *
 *  @return
 */
+ (BOOL)correctMoney:(NSString *)money;

/**
 *  @author YYang, 16-05-22 18:05:33
 *
 *  10. 校验IP-v4地址
 IP4 正则语句。
 *
 *  @param ip ip
 *
 *  @return
 */
+ (BOOL)correctIpv4:(NSString *)ip;
/**
 *  @author YYang, 16-05-22 18:05:31
 *
 *  11. 校验IP-v6地址
 IP6 正则语句。
 *
 *  @param ip ip
 *
 *  @return
 */
+ (BOOL)correctIpv6:(NSString *)ip;


@end
