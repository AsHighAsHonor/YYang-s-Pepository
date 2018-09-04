//
//  UIAlertController+SimpleAlert.m
//  haneco-ios
//
//  Created by YYang on 5/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import "UIAlertController+SimpleAlert.h"

@implementation UIAlertController (SimpleAlert)
+ (void)showMyAlertTitle:(NSString *)title WithMsg:(NSString *)msg andParentController:(UIViewController *)vc andConfirmHandler:(void (^ )(UIAlertAction *action))confirmHandler andCancelHandler:(void (^ )(UIAlertAction *action))cancelHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmHandler){
            confirmHandler(action);
        }
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandler) {
            cancelHandler(action);
        }
        
    }];
    
    
    [alert addAction:action2];
    [alert addAction:action1];
    
    [vc presentViewController:alert animated:YES completion:nil];
    
}


+ (void)sheetWithTitle:(NSString *)title message:(NSString *)msg andParentController:(UIViewController *)vc actions:(NSArray <UIAlertAction *>* )actions withCancel:(BOOL)cancel{
    
    NSMutableArray <UIAlertAction *>*muActions = [NSMutableArray arrayWithArray:actions];
    if (cancel) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [muActions insertObject:action atIndex:actions.count-1];
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction *action in muActions) {
        [alert addAction:action];
    }

    [vc presentViewController:alert animated:YES completion:nil];
    
}


+ (void)alertWithTitle:(NSString *)title message:(NSString *)msg andParentController:(UIViewController *)vc actions:(NSArray <UIAlertAction *>* )actions{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (UIAlertAction *action in actions) {
        [alert addAction:action];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}




+(void)showMyTextFieldAlertWithMsg:(NSString *)msg andParentController:(UIViewController *)vc andTextFieldHandler:(void (^ )(UIAlertAction *action,UIAlertController* alert ))handler{
    __block UIAlertController *alert = [self alertControllerWithTitle:@"Please input new content" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handler(action,alert);
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [vc presentViewController:alert animated:YES completion:nil];
}


+(void)showHintMessage:(NSString*)msg andTitle:(NSString*)title inController:(UIViewController *)vc{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];

    [alert addAction:action1];
    [vc presentViewController:alert animated:YES completion:nil];
}



+(void)addGestureToBackground{
    UIView *backView = [[UIApplication sharedApplication].keyWindow.subviews.lastObject subviews][0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissAlert)];
    
    [backView addGestureRecognizer:tap];
}
-(void)dissmissAlert{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
