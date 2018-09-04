//
//  HttpCallerIntercepter.m
//  trader-ios
//
//  Created by YYang1 on 2/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "HttpCallerIntercepter.h"
#import "Aspects.h"


@implementation HttpCallerIntercepter
+ (void)load{
    [self sharedInstance];
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static HttpCallerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HttpCallerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self beforeHttpCallerIntercepter];
        [self httpHeaderIntercepter];
        [self httpErrorIntercepter];
    }
    return self;
}

- (void)httpHeaderIntercepter{
    [NSObject aspect_hookSelector:@selector(getHeaderFields) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        if ([aspectInfo.instance respondsToSelector:@selector(response)]) {
            id response = [aspectInfo.instance performSelector:@selector(response)];
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                 NSDictionary *headerFields = ((NSHTTPURLResponse *)response).allHeaderFields;
                
                // Cart badge
                NSString *cartQty =[headerFields objectForKey:HeaderCartQuantity];
                if (![cartQty isEqualToString:@"0"]) {
                     [[UIApplication applicationRootViewController]setTabBadgeValue:cartQty atTab:2];
                }else{
                    [[UIApplication applicationRootViewController]setTabBadgeValue:nil atTab:2];
                }
                
                //Notification badge
                NSString *notificationQty =[headerFields objectForKey:HeaderNotificationQuantity];
                if (![notificationQty isEqualToString:@"0"]) {
                    [UIApplication sharedApplication].applicationIconBadgeNumber = notificationQty.integerValue;
                    [[UIApplication applicationRootViewController]setTabBadgeValue:notificationQty atTab:4];
                }else{
                    [[UIApplication applicationRootViewController]setTabBadgeValue:nil atTab:4];
                }
                
                //TOTAL_AVAILABLE_PAW_VALUE
                NSString *pawsValue = [headerFields objectForKey:HeaderPawsValue];
                [GVUserDefaults standardUserDefaults].pawValue = pawsValue;
                
            }
        }

    } error:NULL];
    
}


-(void)httpErrorIntercepter{
    [NSError aspect_hookSelector:@selector(localizedRecoverySuggestion) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        NSError *error = aspectInfo.instance;
        NSDictionary *userInfo = error.userInfo;
        NSData *errorData = userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSHTTPURLResponse* errorResponse = userInfo[AFNetworkingOperationFailingURLResponseErrorKey];

        
        if (errorResponse.statusCode == 401) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [[GVUserDefaults standardUserDefaults]unauthorizedClearUserInfo];
                [[UIApplication applicationRootViewController]showLogin];
                [[UIApplication applicationRootViewController]popAllTabToRoot];
            });
        }
        
        if (errorResponse.statusCode == 410) {
            ErrorModel * errorModel = [ErrorModel mj_objectWithKeyValues:errorData];
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [[NSNotificationCenter defaultCenter] postNotificationName:DashboardCatalogueOrderHomeWillRefreshCategoryCartProductNotification object:nil];
                [[UIApplication applicationRootViewController]popAllTabToRoot];
                [[UIApplication applicationRootViewController]justForYouErrorAlert:errorModel];
            });
        }

        
    } error:NULL];

}


- (void)beforeHttpCallerIntercepter{
    [AFHTTPSessionManager aspect_hookSelector:@selector(requestSerializer) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
        // accessToken is nil Transform to login
        if (![GVUserDefaults standardUserDefaults].accessToken || ![GVUserDefaults standardUserDefaults].userId ) {
            // FIXME: Abort Transform to login
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [[UIApplication applicationRootViewController]showLogin];
            });
            return;
        }
        
        // User did not finish all user information register; Transform to profile or registe Role info
        if ( ![[[GVUserDefaults standardUserDefaults]currentStep] isEqualToString:StartedStep]) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [[UIApplication applicationRootViewController]showLogin];
            });
            return;
        }
        
    } error:NULL];
    
}






@end
