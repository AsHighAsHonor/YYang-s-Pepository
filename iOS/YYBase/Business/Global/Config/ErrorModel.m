//
//	ErrorModel.m
//	https://ashighashonor.github.io



#import "ErrorModel.h"

NSString *const kErrorModelData = @"data";
NSString *const kErrorModelMessage = @"message";
NSString *const kErrorModelType = @"type";

@interface ErrorModel ()
@end
@implementation ErrorModel
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data": [ErrorDataModel class]};
}

-(NSString *)getProductsName{
    NSMutableString *products = [NSMutableString stringWithFormat:@" The following items are no longer available to you: \n \n"];
    for (ErrorDataModel *dataModel in self.data) {
        [products appendFormat:@"%@\n",dataModel.productCatalogueCode];
    }
//    if (products.length > 0) {
//        [products deleteCharactersInRange:NSMakeRange(products.length -3, 3)];
//    }
    return products;
}


@end
