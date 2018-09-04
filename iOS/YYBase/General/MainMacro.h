//
//  MainMacro.h
//  haneco-ios
//
//  Created by YYang on 2/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#ifndef MainMacro_h
#define MainMacro_h

#pragma mark - Masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#pragma mark - WeakSelf
#define DefineWeakSelf __weak __typeof(self) weakSelf = self;

#pragma mark - NSLog
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif


#pragma mark - NSString
#define StrAppend(str1,str2)    ((str1 == nil ||str2 == nil) ? @" " : [str1 stringByAppendingString:str2])
#define BoolTrue @"1"
#define BoolFalse @"0"

#define STANDER_USERDEFAULT [NSUserDefaults standardUserDefaults]
#pragma mark - KeyChain
#define kFirstKey @"firstLaunch"
#define kEverKey @"everLaunched"

#pragma mark - Device
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define TOP_AREA_HEIGHT (IS_IPHONEX ? 88.f : 64.f)
#define STATUS_BAR_HEIGHT (IS_IPHONEX ? 44.f : 24.f)
#define TABBAR_HEIGHT (IS_IPHONEX ? 83.f : 49.f)
#define NAVIGATIONBAR_HEIGHT 44

#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)




#pragma mark - Color
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CLEARCOLOR [UIColor clearColor]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UICOLOR(A)  [UIColor colorWithHexString:A]

#define kNavBarColor UICOLOR(@"#11A9EB")
#define kNavBarGrayColor UICOLOR(@"#FCFCFC")
#define kGrayTextColor UICOLOR(@"#b0b0b0")

#define kStatusBarColor @"blue"
#define PROGRESS_INDICATOR_COLOR [UIColor colorWithHexString:@"BEE345"]
#define ERROR_ICON [UIImage imageNamed:@"alert_icon@2x"]
#define CELL_CEPARATOR_COLOR UICOLOR(@"#C8C7CC")




#pragma mark - Font
#define kCustomFontYaHei @"Microsoft YaHei"
#define ROBOTO_REGULAR @"Roboto-Regular"
#define ROBOTO_BLACK @"Roboto-Black"
#define ROBOTO_MEDIUM @"Roboto-Medium"
#define ROBOTO_BOLD @"Roboto-Bold"


#define kFont_10 [UIFont systemFontOfSize: 10]
#define kFont_12 [UIFont systemFontOfSize: 12]
#define kFont_13 [UIFont systemFontOfSize: 13]
#define kFont_14 [UIFont systemFontOfSize: 14]
#define kFont_15 [UIFont systemFontOfSize: 15]
#define kFont_16 [UIFont systemFontOfSize: 16]
#define kFont_17 [UIFont systemFontOfSize: 17]
#define kFont_20 [UIFont systemFontOfSize: 20]
#define kFont_25 [UIFont systemFontOfSize: 25]



#pragma mark - Singleton
#define SingletonH(methodName) + (instancetype)shared##methodName;
#if __has_feature(objc_arc)
#define SingletonM(methodName) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}

#else

#define SingletonM(methodName) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}

#endif


#endif /* MainMacro_h */

