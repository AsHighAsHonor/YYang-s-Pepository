//
//  RootViewController.h
//  trader-ios
//
//  Created by YYang1 on 18/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController


/**
 show login view
 */
-(void)showLogin;

/**
 Push sidemenu
 */
-(void)showSidemenu;


/**
 Dispaly request view

 @param type callback / email
 */
-(void)showRequest:(NSInteger)type;


/**
 Set badge Value for  Tab

 @param badgeValue badgeValue description
 */
-(void)setTabBadgeValue:(NSString *)badgeValue atTab:(NSInteger )tabIndex;


/**
 Get current selected tab's navigation ctrl

 @param index index description
 @return current navigationController
 */
-(UINavigationController *)getSelectedNavControllerWithIndex:(NSUInteger )index;


/**
 Pop specific tab's navigation controller to root

 @param index specific tab
 */
-(void)popToRoot:(NSUInteger)index;


/**
 Pop all tab to root 
 */
-(void)popAllTabToRoot;


/**
 Set select Tab

 @param index index description
 */
-(void)setSelectTabAtIndex:(NSInteger )index;


-(void)justForYouErrorAlert:(ErrorModel *)error;


@end
