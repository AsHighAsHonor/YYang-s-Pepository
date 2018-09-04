//
//  Constant.h
//  trader-ios
//
//  Created by YYang1 on 18/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSUInteger const ProductMaxLimitation;
extern NSUInteger const NumberOfImagePickerRows;
extern NSUInteger const ImageMaxLimitation;
extern NSUInteger const OriginalImage;

extern NSInteger const PageSize;
extern NSInteger const DashboardHomeMargin;
extern NSString *const HeaderTotalCount;
extern NSString *const HeaderTotalPage;
extern NSString *const HeaderCartQuantity;
extern NSString *const HeaderNotificationQuantity;
extern NSString *const HeaderPawsValue;
extern NSString *const OrderStatusSubmitted;
extern NSString *const UserRoleTypeWholesaler;
extern NSString *const UserRoleTypeApprentice;

extern NSString *const InitialledStep;
extern NSString *const DetailsStep ;
extern NSString *const StartedStep ;

extern NSString *const TransactionableOrderType;
extern NSString *const BranchUnselectedType;


//UserInfo
extern NSString *const UserInfoAbn ;
extern NSString *const UserInfoAccessToken;
extern NSString *const UserInfoAvatar;
extern NSString *const UserInfoBusinessCountry;
extern NSString *const UserInfoBusinessName;
extern NSString *const UserInfoBusinessPostcode;
extern NSString *const UserInfoBusinessState;
extern NSString *const UserInfoBusinessStreet;
extern NSString *const UserInfoBusinessSuburb;
extern NSString *const UserInfoCreatedAt ;
extern NSString *const UserInfoCurrentStep;
extern NSString *const UserInfoEmail;
extern NSString *const UserInfoFbId;
extern NSString *const UserInfoFirstName;
extern NSString *const UserInfoHasPassword ;
extern NSString *const UserInfoSurprise ;
extern NSString *const UserInfoUserId ;
extern NSString *const UserInfoJacketSize;
extern NSString *const UserInfoLastName;
extern NSString *const UserInfoLicenceNumPrimary ;
extern NSString *const UserInfoLicenceNumSecond ;
extern NSString *const UserInfoMobile ;
extern NSString *const UserInfoNotificationSound;
extern NSString *const UserInfoOptionalBranchIds ;
extern NSString *const UserInfoOptionalBranches ;
extern NSString *const UserInfoOtherBranches ;
extern NSString *const UserInfoPawValue ;
extern NSString *const UserInfoPoloSize ;
extern NSString *const UserInfoPosition ;
extern NSString *const UserInfoPostalCountry;
extern NSString *const UserInfoPostalPostcode;
extern NSString *const UserInfoPostalState;
extern NSString *const UserInfoPostalStreet;
extern NSString *const UserInfoPostalSuburb;
extern NSString *const UserInfoPreferredBranchId;
extern NSString *const UserInfoType;
extern NSString *const UserInfoUnreadAppNotificationNum;
extern NSString *const UserInfoUpdatedAt;
extern NSString *const UserInfoPreferredBranch;
extern NSString *const UserInfoDeviceToken;
extern NSString *const UserInfoEnableRememberMe;
extern NSString *const UserInfoEnableAuthentication;


#pragma mark - NotificationName
//[Name of associated class] + [Did | Will] + [UniquePartOfName] + Notification
extern NSString *const DashboardCatalogueOrderHomeWillRefreshCategoryCartProductNotification;
extern NSString *const ProfileNotificationDetailWillDisplayNotification;
extern NSString *const LoginControllerWillTriggerAutoLoginNotification;
extern NSString *const LoginControllerWillTriggerPlayAudioNotification;
extern NSString *const WolfHowlManagerWillTriggerPlayAudioNotification;
extern NSString *const WolfHowlManagerWillTriggerLunchScreenNotification;

#pragma mark - Segue

extern NSString *const RootToLoginSegue;
extern NSString *const RootToTabBarSegue;
extern NSString *const RootMoveSideMenuSegue;
extern NSString *const RootToRequestSegue;
extern NSString *const RegisterBaseToRegisterRoleSegue;
extern NSString *const LoginToRegisterBaseSegue;
extern NSString *const RegisterRoleToBranchSegue;
extern NSString *const LoginToRegisterRoleSegue;
extern NSString *const LoginToResetPasswordSegue;


extern NSString *const DashboardHomeToImageSegue;
extern NSString *const DashboardHomeToNewProductSegue;
extern NSString *const DashboardHomeToFunctionSegue;
extern NSString *const DashboardHomeToCotegoriesSegue ;
extern NSString *const DashboardHomeToWebviewSegue;

extern NSString *const CategoryToRangeSegue;
extern NSString *const RangeToPorductListSegue;
extern NSString *const CategoryToProductListSegue;
extern NSString *const RangeToDetailSegue;

extern NSString *const ProfileBusinessDetailsSegue;
extern NSString *const ProfileHomeToResetSegue;
extern NSString *const ProfileHomeToNotificationListSegue;
extern NSString *const ProfileHomeToEditSegue;
extern NSString *const NotificationsToNotificationDetailsSegue;
extern NSString *const ProfileHomeToNotificationSoundSegue;


extern NSString *const CartToOrderHistorySegue;
extern NSString *const CartToOrderBranchSegue;
extern NSString *const CartToOrderDetailSegue;
extern NSString *const OrderHistoryListToOrderDetailSegue ;
extern NSString *const OrderDetailToPurchaseSegue ;
extern NSString *const OrderBranchToOrderDetailSegue;

extern NSString *const PawStoreListToPawStoreDetailSegue;
extern NSString *const PawStoreProductListToHistoryListSegue;


