 //
//  ValidateUtil.m
//  SalesAssisant
//
//  Created by YYang on 16/1/5.
//  Copyright (c) 2015年 ztesoft. All rights reserved.
//

#import "ValidateUtil.h"

@implementation ValidateUtil

#pragma mark 验证手机号码
+ (BOOL) isPhoneNum: (NSString *)phoneNum {
    
    //暂只验证1开头+10位数字的格式
    NSString *reg = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: phoneNum] == YES) {
        return YES;
    }
    
    return NO;
}
#pragma mark 验证手机号码
+ (BOOL) isCardNo: (NSString *)cardNo {
    
    if (cardNo.length <16) {
        return NO;
    }
    
    return YES;
}

#pragma mark 验证身份证号码
+ (BOOL) isCardNum: (NSString *)cardNum {
    
    //暂只验证1开头+10位数字的格式
    NSString *reg = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: cardNum] == YES) {
        return YES;
    }
    
    return NO;
}

#pragma mark 验证是否为空字符串、空格等
+ (BOOL) isEmptyStr: (NSString *)str {
    
    if (nil == str) return YES;
    
    if (NULL == str) return YES;
    
    if ([str isKindOfClass: [NSNull class]]) return YES;
    
    if ([[str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return  YES;
    }
    
    return NO;
}

#pragma mark 验证是否为整形
+ (BOOL)isPureInt:(NSString *)str {
    NSScanner *scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark 验证是否为浮点
+ (BOOL)isPureFloat:(NSString *)str {
    NSScanner * scan = [NSScanner scannerWithString:str];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

#pragma mark 验证是否数字
+ (BOOL)isNumber:(NSString *)str {
    return [ValidateUtil isPureInt:str] || [ValidateUtil isPureFloat:str];
}

/**
 *  验证是否正确的电信手机号码
 *
 *  @param phoneNumber 手机号码
 *
 *  @return 校验结果
 */
+ (BOOL)isTelecomNumber:(NSString *)phoneNumber {
    NSString *reg = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: phoneNumber] == YES) {
        return YES;
    }
    
    return NO;
}

/**
 *  是否正确固话
 *
 *  @param ghNumber 四位区号
 *
 *  @return 校验结果
 */
+ (BOOL)isGHNumber:(NSString *)ghNumber {
    NSString *reg = @"^(0\\d{3})+(-)?\\d{7,8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: ghNumber] == YES) {
        return YES;
    }
    
    return NO;
}

/**
 *  验证是否正确的人名
 *
 *  @param name 人名
 *
 *  @return 校验结果
 */
+ (BOOL)isSureName:(NSString *)name {
    NSString *reg = @"[\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: name] == YES) {
        return YES;
    }
    
    return NO;
}

/**
 *  验证是否正确的邮箱地址
 *
 *  @param email 邮箱地址
 *
 *  @return 校验结果
 */
+ (BOOL)isEmail:(NSString *)email {
    NSString *reg = @"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: email] == YES) {
        return YES;
    }
    
    return NO;
}



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
+ (BOOL)rightPasswordStrength:(NSString *)password {
    NSString *reg = @"^(?=.*\\\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: password] == YES) {
        return YES;
    }
    
    return NO;
}


+ (BOOL)isChinese:(NSString *)text {
    NSString *reg = @"^[\\\\u4e00-\\\\u9fa5]{0,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: text] == YES) {
        return YES;
    }
    
    return NO;
}




+ (BOOL)onlyNumEngUnderLine:(NSString *)text {
    NSString *reg = @"^\\\\w+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: text] == YES) {
        return YES;
    }
    
    return NO;
}



+ (BOOL )verifyIdCardNum:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }

}


+ (BOOL)correctDate:(NSString *)date {
    NSString *reg = @"^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: date] == YES) {
        return YES;
    }
    
    return NO;
}


+ (BOOL)correctMoney:(NSString *)money{
    NSString *reg = @"^[0-9]+(.[0-9]{2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: money] == YES) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)correctIpv4:(NSString *)ip {
    NSString *reg = @"\\\\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: ip] == YES) {
        return YES;
    }
    
    return NO;
}



+ (BOOL)correctIpv6:(NSString *)ip {
    NSString *reg = @"(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", reg];
    
    if ([pred evaluateWithObject: ip] == YES) {
        return YES;
    }
    
    return NO;
}





@end
