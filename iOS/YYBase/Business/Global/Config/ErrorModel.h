#import <UIKit/UIKit.h>
#import "ErrorDataModel.h"

@interface ErrorModel : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * type;


-(NSString *)getProductsName;
@end
