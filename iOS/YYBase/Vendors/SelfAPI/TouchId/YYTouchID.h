//
//  YYTouchID.h
//  haneco-ios
//
//  Created by YYang on 29/3/18.
//  Copyright © 2018 PixelForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@protocol YYTouchIdDelegate <NSObject>
@required
/**
 *
 *  验证成功
 */
- (void)authorizeSuccess;
/**
 *
 *  验证失败
 * Authentication was not successful, because user failed to provide valid credentials.
 */
- (void)authorizeFailure;

/**
 *
 *  当前设备不支持生物识别
  * The device does not support biometry.
 */
- (void)authorizeNotSupport;

@optional

/**
 *
 *  取消了验证（点击了取消）
 * Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void)authorizeUserCancel;

/**
 *
 *  在TouchID对话框点击输入密码按钮
 * Authentication was canceled, because the user tapped the fallback button (Enter Password).
 */
- (void)authorizeUserFallBack;

/**
 *
 *   在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 * Authentication was canceled by system (e.g. another application went to foregroun
 */
- (void)authorizeSystemCancel;

/**
 *
 *  无法使用TouchID,设备没有设置密码
 * Authentication could not start, because passcode is not set on the device.
 */
- (void)authorizePasswordNotSet;


/**
 *
 *  该设备的TouchID无效
 * Authentication could not start, because Touch ID is not available on the device.
 */
- (void)authorizeTouchIDNotAvailable;


/**
 *Authentication could not start, because Touch ID has no enrolled fingers.
 */
- (void)authorizeTouchIDNotEnrolled;


/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 * Authentication was not successful, because there were too many failed Touch ID attempts and
 * Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating
 *  LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 */
- (void)authorizeTouchIDLockOut;

/**
 *
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *  Authentication was canceled by application (e.g. invalidate was called while
 *  authentication was in progress).
 */
- (void)authorizeTouchIDAppCancel;

/**
 *
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 * LAContext passed to this call has been previously invalidated.
 */
- (void)authorizeTouchIDInvalidContext;



/**
 /// Authentication failed, because it would require showing UI which has been forbidden
 /// by using interactionNotAllowed property.
 */
-(void)authorizeNotInteractive;


@end

@interface YYTouchID : NSObject
SingletonH(Instance)

@property(nonatomic,assign) id<YYTouchIdDelegate>touchIdDelegate;

-(BOOL)canAuthorizeDelegate:(id<YYTouchIdDelegate>)delegate;

- (void)startTouchIDWithMessage:(NSString *)message andFallBackTitle:(NSString *)title andDelegate:(id<YYTouchIdDelegate>)delegate;

@end
