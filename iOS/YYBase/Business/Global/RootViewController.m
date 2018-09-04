//
//  RootViewController.m
//  trader-ios
//
//  Created by YYang1 on 18/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property(nonatomic,weak)UIViewController *loginCtrl;
@property(nonatomic,weak)UIViewController *registerRoleInfoCtrl;

@end

@implementation RootViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReciveRemoteNotification:) name:ProfileNotificationDetailWillDisplayNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark - Delegate Methods

-(void)didReciveRemoteNotification:(NSNotification *)notify{
    [self setSelectTabAtIndex:4];
    UINavigationController *nav =  [self getSelectedNavControllerWithIndex:4];
    if (!nav || ![notify.name isEqualToString:ProfileNotificationDetailWillDisplayNotification]) {
        return;
    }
    NSString *appNotificationId = ((NSNumber *)notify.userInfo[@"params"][@"app_notification_id"]).stringValue;
    UIViewController *ctrl = nav.viewControllers.lastObject;
    if ([ctrl isKindOfClass:NSClassFromString(@"ProfileNotificationDeatilController")]) {
        [ctrl setValue:appNotificationId forKey:@"appNotificationId"];
        [ctrl performSelector:@selector(getNotificationDetail)];
    } else {
        UIViewController *notiDetail  = [UIStoryboard loadController:@"ProfileNotificationDeatilController" storyBoard:@"Profile"];
        [notiDetail setValue:appNotificationId forKey:@"appNotificationId"];
        [nav pushViewController:notiDetail animated:YES];
    }
}


-(void)setSelectTabAtIndex:(NSInteger )index{
    for (UIViewController *ctrl  in self.childViewControllers) {
        if ([ctrl isKindOfClass:[UITabBarController class]]) {
            [(UITabBarController *)ctrl setSelectedIndex:index];
        }
    }
}

-(void)setTabBadgeValue:(NSString *)badgeValue atTab:(NSInteger )tabIndex{
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITabBarController class]]) {
            UITabBarItem *item = [[[obj tabBar] items] objectAtIndex:tabIndex];
            item.badgeValue = badgeValue;
            *stop = YES;
        }
    }];
    
}

-(UINavigationController *)getSelectedNavControllerWithIndex:(NSUInteger )index{
    for (UIViewController *ctrl  in self.childViewControllers) {
        if ([ctrl isKindOfClass:[UITabBarController class]]) {
            [(UITabBarController *)ctrl setSelectedIndex:index];
            return ((UITabBarController *)ctrl).selectedViewController;
        }
    }
    return nil;
}

-(void)showLogin{
    if (!self.loginCtrl) {
        [self performSegueWithIdentifier:RootToLoginSegue sender:nil];
    }
}

-(void)showSidemenu{
    [self performSegueWithIdentifier:RootMoveSideMenuSegue sender:nil];
}

-(void)showRequest:(NSInteger)type{
    [self performSegueWithIdentifier:RootToRequestSegue sender:@(type)];
}

-(void)updateUserInfo{
    UINavigationController *nav =  [self getSelectedNavControllerWithIndex:4];
    if (!nav || self.registerRoleInfoCtrl) {
        return;
    }
    self.registerRoleInfoCtrl = [UIStoryboard loadController:@"RegisterRoleInfoController" storyBoard:@"Main"];
    [self.registerRoleInfoCtrl setValue:@YES forKey:@"profile"];
    [nav pushViewController:self.registerRoleInfoCtrl animated:YES];
}

-(void)popToRoot:(NSUInteger)index{
    UINavigationController *nav = [self getSelectedNavControllerWithIndex:index];
    if (nav) {
        [nav popToRootViewControllerAnimated:NO];
    }
}

-(void)popAllTabToRoot{
    for (UIViewController *ctrl  in self.childViewControllers) {
        if ([ctrl isKindOfClass:[UITabBarController class]]) {
            NSArray * navs = ctrl.childViewControllers;
            for (UIViewController *ctrl  in navs) {
                if ([ctrl isKindOfClass:[UINavigationController class]]) {
                    UINavigationController *nav =  (UINavigationController *)ctrl;
                    if (nav.viewControllers.count >1) {
                        nav.viewControllers = @[nav.viewControllers.firstObject];
                    }
                }
            }
        }
    }
}

-(void)justForYouErrorAlert:(ErrorModel *)error{
    [UIAlertController showHintMessage:error.getProductsName andTitle:@"Some items have been removed from your order!" inController:self];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:RootToLoginSegue]){
        self.loginCtrl = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:RootToRequestSegue]) {
        UINavigationController *nav = segue.destinationViewController;
        UIViewController *desCtrl =  nav.viewControllers.firstObject;
        [desCtrl setValue:sender forKey:@"type"];
    }
    
}



#pragma mark -Getters and Setters



@end
