//
//  HanecoControllerIntercepter.m
//  haneco-ios
//
//  Created by YYang on 14/4/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "ControllerConfig.h"
#import "Aspects.h"

@interface ControllerConfig()
@property(nonatomic,strong)NSMutableSet*exceptCtrl;
@property(nonatomic,strong)NSMutableSet*exceptLoginCtrl;


@end

@implementation ControllerConfig
+ (void)load{
    [self sharedInstance];
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static ControllerConfig *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ControllerConfig alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self viewWillAppearIntercepter];
        [self viewDidLoadIntercepter];
    }
    return self;
}

- (void)viewWillAppearIntercepter{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        UIViewController *ctrl = aspectInfo.instance;
        if ([self isExceptClass:self.exceptCtrl controller:ctrl]) {
            return ;
        }
        // Set nav
        [ctrl setNavigationBarBackgourndColor:BACKGROUND_COLOR andTintColor:DARK_GRAY_COLOR];
        if ([ctrl respondsToSelector:@selector(showUnderlineConfig)]) {
            [ctrl showNavigationBarUnderline];
        }else{
            [ctrl hideNavigationBarUnderline];
        }
    
    } error:NULL];

}


-(void)viewDidLoadIntercepter{
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        UIViewController *ctrl = aspectInfo.instance;
        //controller filter
        if ([self isExceptClass:self.exceptCtrl controller:ctrl]) {
            return ;
        }
        [ctrl.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: DARK_GRAY_COLOR, NSFontAttributeName : [UIFont fontWithName:ROBOTO_MEDIUM size:16]}];
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        [attributes setValue:DARK_GRAY_COLOR forKey:NSForegroundColorAttributeName];
        [attributes setValue:[UIFont fontWithName:ROBOTO_MEDIUM size:16] forKey:NSFontAttributeName];
        [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        ctrl.view.backgroundColor = BACKGROUND_COLOR;
        
        //Add a line under tht tabbar
        if (ctrl.tabBarController) {
            UIView *line = [UIView viewWithFrame:CGRectMake(0, ctrl.tabBarController.tabBar.bounds.origin.y-1, ctrl.view.frame.size.width, 1) backgroundColor:UICOLOR(@"#C2C3C5")];
            [ctrl.view addSubview:line];
        }
        
        
    } error:NULL];
}

-(BOOL)isExceptClass:(NSSet *)set controller:(UIViewController *)controller{
    BOOL res = YES ;
    for (NSString* ctrlName in set) {
        if ([controller isKindOfClass:NSClassFromString(ctrlName)]) {
            res = YES;
            break;
        }else{
            res = NO;
        }
    }
    return res;
}



-(NSMutableSet *)exceptCtrl{
    if(!_exceptCtrl){
        _exceptCtrl = [NSMutableSet set];
        [_exceptCtrl addObject:@"UICompatibilityInputViewController"];
        [_exceptCtrl addObject:@"UIInputWindowController"];
        [_exceptCtrl addObject:@"_UIAlertControllerTextFieldViewController"];
        [_exceptCtrl addObject:@"UIAlertController"];
        [_exceptCtrl addObject:@"SFBrowserRemoteViewController"];
        [_exceptCtrl addObject:@"SFAuthenticationViewController"];
        [_exceptCtrl addObject:@"UIApplicationRotationFollowingControllerNoTouches"];
        [_exceptCtrl addObject:@"RootViewController"];
        [_exceptCtrl addObject:@"SideMenuController"];
        [_exceptCtrl addObject:@"SideMenuTableViewController"];
        [_exceptCtrl addObject:@"SWActionSheetVC"];
        [_exceptCtrl addObject:@"MFMailComposeInternalViewController"];
        [_exceptCtrl addObject:@"MFMailComposePlaceholderViewController"];
        [_exceptCtrl addObject:@"MFMailComposeViewController"];
        [_exceptCtrl addObject:@"MFMailComposeRemoteViewController"];
    }
    return _exceptCtrl;
}

-(NSMutableSet *)exceptLoginCtrl{
    if(!_exceptLoginCtrl){
        _exceptLoginCtrl = [NSMutableSet set];
        [_exceptLoginCtrl setByAddingObjectsFromSet:self.exceptCtrl];
        [_exceptLoginCtrl addObject:@"RegisterRoleInfoController"];
        [_exceptLoginCtrl addObject:@"RegisterBaseInfoController"];
        [_exceptLoginCtrl addObject:@"ProfileHomeController"];
        [_exceptLoginCtrl addObject:@"LoginViewController"];
    }
    
    return _exceptLoginCtrl;
}



@end
