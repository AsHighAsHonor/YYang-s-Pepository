//
//  BusinessMacro.h
//  haneco-ios
//
//  Created by YYang on 4/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#ifndef BusinessMacro_h
#define BusinessMacro_h


#import "TraderConstant.h"
#import "NSDictionary+ErrorDescription.h"
#import "NSString+Paws.h"
#import "GVUserDefaults.h"
#import "ErrorModel.h"
#import "ErrorDataModel.h"

#define GSME_EMAIL @"service@gsme.com.au"
#define BANNER_URL_3 @"http://www.gsme.com.au/uploads/downloads/Jacket_Info.pdf"
#define BANNER_URL_4 @"http://www.gsme.com.au/uploads/downloads/Jacket_Info.pdf"

#pragma mark - FaceBook
#define FB_APP_ID @"196620027786849"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#pragma mark - MagicalRecord
//#define Default_Context [NSManagedObjectContext MR_defaultContext]
//#define Encrypt_Key @"PixelForce"

#pragma mark - LBXScan
//#ifdef __OBJC__
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
//
//#define LBXScan_Define_Native
//#define LBXScan_Define_UI
//#endif

#pragma mark - Color
#define BACKGROUND_COLOR [UIColor colorWithHexString:@"E8E8EA"]
#define BUTTON_FACEBOOK_COLOR [UIColor colorWithHexString:@"39579A"]
#define BUTTON_FACEBOOK_CONNECTED_COLOR [UIColor colorWithHexString:@"A5C1FF"]

#define GREEN_COLOR [UIColor colorWithHexString:@"C5E74E"]
#define DARK_GRAY_COLOR  [UIColor colorWithHexString:@"464D53"]
#define LIGHT_GRAY_COLOR  [UIColor colorWithHexString:@"7E8287"]
#define SOFT_GRAY_COLOR  [UIColor colorWithHexString:@"9CA2AA"]
#define WHITE_GRAY_COLOR  [UIColor colorWithHexString:@"989FA7"]
#define BADGE_RED_COLOR  [UIColor colorWithHexString:@"FF4A4A"]
#define INDICATOR_COLOR  [UIColor grayColor]
#define UNREAD_NOTIFY_BACKGROUND_COLOR  [UIColor colorWithHexString:@"F7F7F7"]


#pragma mark - Image
//#define PLACEHOLDER [UIImage imageNamed:@"icons8-full-image-100"]
//#define PLACEHOLDER [UIImage imageNamed:@"image_holder"]
#define PLACEHOLDER [UIImage imageWithColor:[UIColor whiteColor]]
#define USER_PLACEHOLDER [UIImage imageNamed:@"default-user-icon"]
#define NOTIFICATION_PLACEHOLDER [UIImage imageNamed:@"Trader-round-logo-icon"]
#define BACKGROUND_IMAGE @"wolf_login_screen"
#define HELP_CENTER_IMAGW @"Help-with-text_-_Green (1)"
#define ORDER_NUMBER_FORMATER(numberStr) [NSString stringWithFormat:@"# %08.0f", numberStr.floatValue]


#pragma mark - List Empty
#define LIST_EMPTY_PLACEHOLDER [UIImage imageNamed:@"Claw Green"]
#define LIST_EMPTY_BUTTON_NORMAL_BACKGROUND [UIImage imageNamed:@"button_background_icloud_normal"]
#define LIST_EMPTY_BUTTON_HIGHLIGHT_BACKGROUND [UIImage imageNamed:@"button_background_icloud_highlight"]


#define REDEEM_ALERT_TITLE(str) [NSString stringWithFormat:@"Redeem %@ ",str]
#define REDEEM_ALERT_MSG(str1,str2) [NSString stringWithFormat:@"Are you sure you want redeem the %@ for %@ Paws?",str1,str2]
#define REDEEM_ALERT_FAIL_TITLE @"Not Enough Paws!"
#define REDEEM_ALERT_FAIL_MSG(str1, str2) [NSString stringWithFormat:@"You still need %@ paws before you're eligble to redeem the %@ ",str1,str2]
#define REDEEM_ALERT_SUCCESS_TITLE(str) [NSString stringWithFormat:@"Your have redeemed the %@ !",str]
#define REDEEM_ALERT_SUCCESS_MSG(str1) [NSString stringWithFormat:@"Trader will dispatch your %@ shortly!",str1]

#define IS_WHOLESALER (([GVUserDefaults standardUserDefaults].type && [[GVUserDefaults standardUserDefaults].type isEqualToString:UserRoleTypeWholesaler]) ? YES : NO) 





#endif /* BusinessMacro_h */
