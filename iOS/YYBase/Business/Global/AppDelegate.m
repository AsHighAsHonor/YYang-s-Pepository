//
//  AppDelegate.m
//  trader-ios
//
//  Created by YYang1 on 17/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "IQKeyboardManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <AWSAuthCore.h>
#import <AWSPinpoint/AWSPinpoint.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <UserNotifications/UserNotifications.h>
#import "WolfHowlManager.h"


@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property (nonatomic,assign)BOOL isInitialized;
@property(atomic) AWSPinpoint *pinpoint;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSDictionary *pushInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [self replyPushNotificationAuthorization:application];
    BOOL didFinishLaunching = [self launchConfigureApplication:application options:launchOptions];
    return didFinishLaunching;
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GVUserDefaults standardUserDefaults].deviceToken = deviceToken.description;
    NSLog(@"deviceTokenDescription----->>>>>%@",deviceToken.description);
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"[DeviceToken Error]:%@\n",error.description);
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[GVUserDefaults standardUserDefaults] facebookClearUserInfo];
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[GVUserDefaults standardUserDefaults] facebookClearUserInfo];
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return handled;
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"userInfo----->>>>>%@",userInfo);
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive) {
    }
    else if (state == UIApplicationStateInactive) {
    }
    else if (state == UIApplicationStateBackground) {
    }
    completionHandler(UIBackgroundFetchResultNewData);

}



-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"notification----->>>>>%@",notification);
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    UNNotificationContent *content = response.notification.request.content;
    NSLog(@"content.userInfo----->>>>>%@",content.userInfo);
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ProfileNotificationDetailWillDisplayNotification object:nil userInfo:content.userInfo];
    }
    completionHandler();
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    [[UIApplication applicationRootViewController]showLogin];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter]postNotificationName:WolfHowlManagerWillTriggerLunchScreenNotification object:nil userInfo:nil];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]postNotificationName:WolfHowlManagerWillTriggerPlayAudioNotification object:nil userInfo:nil];


}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    [[NSNotificationCenter defaultCenter]postNotificationName:WolfHowlManagerWillTriggerLunchScreenNotification object:nil userInfo:nil];
}

#pragma mark - Configuration

-(BOOL)launchConfigureApplication:(UIApplication *)application options:(NSDictionary *)launchOptions{
    
    [[WolfHowlManager sharedInstance]addNotificationObserve];
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarBySubviews;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [FBSDKSettings setAppID:FB_APP_ID];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    [Fabric with:@[[Crashlytics class]]];
    
    [AWSDDLog sharedInstance].logLevel = AWSDDLogLevelInfo;
    self.pinpoint = [AWSPinpoint pinpointWithConfiguration:[AWSPinpointConfiguration defaultPinpointConfigurationWithLaunchOptions:launchOptions]];
    
    BOOL didFinishLaunching =  [[AWSSignInManager sharedInstance]interceptApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    if (!self.isInitialized) {
        [[AWSSignInManager sharedInstance] resumeSessionWithCompletionHandler:^(id  _Nullable result, NSError * _Nullable error) {
//            NSLog(@"AWSSING----->>>>>%@ \n %@",result,error.description);
        }];
        self.isInitialized = YES;
    }
    
    return didFinishLaunching;

}


#pragma mark - registerForRemoteNotifications
- (void)replyPushNotificationAuthorization:(UIApplication *)application{
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error && granted) {
            NSLog(@"用户点击允许");
        }else{
            NSLog(@"用户点击不允许");
        }
    }];

    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"GetUserNotificationSettings========%@",settings);
    }];
    
    [application registerForRemoteNotifications];
}



@end
