//
//  Constant.m
//  trader-ios
//
//  Created by YYang1 on 18/4/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "TraderConstant.h"
NSInteger const PageSize = 50;
NSInteger const DashboardHomeMargin = 6;

NSUInteger const ProductMaxLimitation = 9999;
NSUInteger const NumberOfImagePickerRows = 2;
NSUInteger const ImageMaxLimitation = 10;

NSUInteger const OriginalImage = 1;



NSString *const HeaderTotalCount = @"TOTAL_COUNT";
NSString *const HeaderTotalPage = @"TOTAL_PAGE";
NSString *const HeaderCartQuantity = @"TOTAL_CART_QTY";
NSString *const HeaderNotificationQuantity = @"TOTAL_UNREAD_NOTIFICATION_NUM";
NSString *const HeaderPawsValue = @"TOTAL_AVAILABLE_PAW_VALUE";

//['Apprentice', 'Contractor', 'Electrician', 'Wholesaler']
NSString *const OrderStatusSubmitted = @"submitted";
NSString *const UserRoleTypeWholesaler = @"Wholesaler";
NSString *const UserRoleTypeApprentice = @"Apprentice";


NSString *const InitialledStep = @"initialled";
NSString *const DetailsStep = @"details";
NSString *const StartedStep = @"started";

NSString *const TransactionableOrderType = @"Order";

//0 unselected 1 prefered 3 options
NSString *const BranchUnselectedType = @"0";


//UserInfo
NSString *const UserInfoAbn = @"abn";
NSString *const UserInfoAccessToken = @"accessToken";
NSString *const UserInfoAvatar = @"avatar";
NSString *const UserInfoBusinessCountry = @"business_country";
NSString *const UserInfoBusinessName = @"business_name";
NSString *const UserInfoBusinessPostcode = @"business_postcode";
NSString *const UserInfoBusinessState = @"business_state";
NSString *const UserInfoBusinessStreet = @"business_street";
NSString *const UserInfoBusinessSuburb = @"business_suburb";
NSString *const UserInfoCreatedAt = @"created_at";
NSString *const UserInfoCurrentStep = @"currentStep";
NSString *const UserInfoEmail = @"email";
NSString *const UserInfoFbId = @"fb_id";
NSString *const UserInfoFirstName = @"first_name";
NSString *const UserInfoHasPassword = @"hasPassword";
NSString *const UserInfoUserId = @"userId";
NSString *const UserInfoJacketSize = @"jacket_size";
NSString *const UserInfoLastName = @"last_name";
NSString *const UserInfoLicenceNumPrimary = @"licence_num_primary";
NSString *const UserInfoLicenceNumSecond = @"licence_num_second";
NSString *const UserInfoMobile = @"mobile";
NSString *const UserInfoNotificationSound = @"notificationSound";
NSString *const UserInfoOptionalBranchIds = @"optional_branch_ids";
NSString *const UserInfoOptionalBranches = @"optional_branches";
NSString *const UserInfoOtherBranches = @"other_branches";
NSString *const UserInfoPawValue = @"pawValue";
NSString *const UserInfoPoloSize = @"polo_size";
NSString *const UserInfoPosition = @"position";
NSString *const UserInfoPostalCountry = @"postal_country";
NSString *const UserInfoPostalPostcode = @"postal_postcode";
NSString *const UserInfoPostalState = @"postal_state";
NSString *const UserInfoPostalStreet = @"postal_street";
NSString *const UserInfoPostalSuburb = @"postal_suburb";
NSString *const UserInfoPreferredBranchId = @"preferred_branch_id";
NSString *const UserInfoType = @"type";
NSString *const UserInfoUnreadAppNotificationNum = @"unreadAppNotificationNum";
NSString *const UserInfoUpdatedAt = @"updated_at";
NSString *const UserInfoPreferredBranch = @"preferred_branch";
NSString *const UserInfoDeviceToken = @"deviceToken";
NSString *const UserInfoSurprise = @"surprise";
NSString *const UserInfoEnableRememberMe = @"enableRememberMe";
NSString *const UserInfoEnableAuthentication = @"enableAuthentication";



//[Name of associated class] + [Did | Will] + [UniquePartOfName] + Notification
NSString *const DashboardCatalogueOrderHomeWillRefreshCategoryCartProductNotification = @"DashboardCatalogueOrderHomeWillRefreshCategoryCartProductNotification";
NSString *const ProfileNotificationDetailWillDisplayNotification = @"ProfileNotificationDetailWillDisplayNotification";
NSString *const LoginControllerWillTriggerAutoLoginNotification = @"LoginControllerWillTriggerAutoLoginNotification";
NSString *const LoginControllerWillTriggerPlayAudioNotification = @"LoginControllerWillTriggerPlayAudioNotification";
NSString *const WolfHowlManagerWillTriggerPlayAudioNotification = @"WolfHowlManagerWillTriggerPlayAudioNotification";
NSString *const WolfHowlManagerWillTriggerLunchScreenNotification = @"WolfHowlManagerWillTriggerLunchScreenNotification";




NSString *const RootToLoginSegue = @"RootToLogin";
NSString *const RootToTabBarSegue = @"RootToTabBar";
NSString *const RootToRequestSegue = @"RootToRequest";
NSString *const RootMoveSideMenuSegue = @"RootMoveSideMenu";
NSString *const RegisterBaseToRegisterRoleSegue = @"RegisterBaseToRegisterRole";
NSString *const LoginToRegisterBaseSegue = @"LoginToRegisterBase";
NSString *const RegisterRoleToBranchSegue = @"RegisterRoleToBranch";
NSString *const LoginToRegisterRoleSegue = @"LoginToRegisterRole";

NSString *const LoginToResetPasswordSegue = @"LoginToResetPassword";


NSString *const DashboardHomeToImageSegue = @"DashboardHomeToImage";
NSString *const DashboardHomeToNewProductSegue = @"DashboardHomeToNewProduct";
NSString *const DashboardHomeToFunctionSegue = @"RootMoveSideMenu";
NSString *const DashboardHomeToCotegoriesSegue = @"DashboardHomeToFunction";
NSString *const DashboardHomeToWebviewSegue = @"DashboardHomeToWebview";


NSString *const CategoryToRangeSegue = @"CategoryToRange";
NSString *const RangeToPorductListSegue = @"RangeToPorductList";
NSString *const CategoryToProductListSegue = @"CategoryToProductList";

NSString *const ProfileBusinessDetailsSegue = @"ProfileBusinessDetails";
NSString *const ProfileHomeToResetSegue = @"ProfileHomeToReset";

NSString *const ProfileHomeToNotificationListSegue = @"ProfileHomeToNotificationList";
NSString *const RangeToDetailSegue = @"RangeToDetail";



NSString *const CartToOrderHistorySegue = @"CartToOrderHistory";
NSString *const CartToOrderBranchSegue = @"CartToOrderBranch";
NSString *const OrderHistoryListToOrderDetailSegue = @"OrderHistoryListToOrderDetail";
NSString *const OrderDetailToPurchaseSegue = @"OrderDetailToPurchase";
NSString *const OrderBranchToOrderDetailSegue = @"OrderBranchToOrderDetail";
NSString *const CartToOrderDetailSegue = @"CartToOrderDetail";

NSString *const ProfileHomeToEditSegue = @"ProfileHomeToEdit";
NSString *const NotificationsToNotificationDetailsSegue = @"NotificationsToNotificationDetails";
NSString *const ProfileHomeToNotificationSoundSegue = @"ProfileHomeToNotificationSound";

NSString *const PawStoreListToPawStoreDetailSegue = @"PawStoreListToPawStoreDetail";
NSString *const PawStoreProductListToHistoryListSegue = @"PawStoreProductListToHistoryList";







