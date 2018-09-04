//
//	ErrorData.m
//	https://ashighashonor.github.io



#import "ErrorDataModel.h"

NSString *const kErrorDataProductCatalogueCode = @"product_catalogue_code";
NSString *const kErrorDataProductCategoryName = @"product_category_name";
NSString *const kErrorDataProductId = @"product_id";
NSString *const kErrorDataProductRangeName = @"product_range_name";

@interface ErrorDataModel ()
@end
@implementation ErrorDataModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName mj_underlineFromCamel];
}

@end
