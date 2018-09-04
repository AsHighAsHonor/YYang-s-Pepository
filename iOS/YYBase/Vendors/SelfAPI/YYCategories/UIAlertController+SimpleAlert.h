//
//  UIAlertController+SimpleAlert.h
//  haneco-ios
//
//  Created by YYang on 5/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (SimpleAlert)
/**
 *  @author YYang, 16-06-19 16:06:57
 *
 *   Alertcontroller   only contain "OK/Cancel"actions
 *
 *  @param msg            Alert content
 *  @param vc             OwnerController
 *  @param confirmHandler OK callback
 *  @param cancelHandler  Cancel callback
 */
+ (void)showMyAlertTitle:(NSString *)title WithMsg:(NSString *)msg andParentController:(UIViewController *)vc andConfirmHandler:(void (^ )(UIAlertAction *action))confirmHandler andCancelHandler:(void (^ )(UIAlertAction *action))cancelHandler;



+ (void)sheetWithTitle:(NSString *)title message:(NSString *)msg andParentController:(UIViewController *)vc actions:(NSArray <UIAlertAction *>* )actions withCancel:(BOOL)cancel;



+ (void)alertWithTitle:(NSString *)title message:(NSString *)msg andParentController:(UIViewController *)vc actions:(NSArray <UIAlertAction *>* )actions;



+(void)showHintMessage:(NSString*)msg andTitle:(NSString*)title inController:(UIViewController *)vc;



+(void)showMyTextFieldAlertWithMsg:(NSString *)msg andParentController:(UIViewController *)vc andTextFieldHandler:(void (^ )(UIAlertAction *action,UIAlertController* alert ))handler;
@end
