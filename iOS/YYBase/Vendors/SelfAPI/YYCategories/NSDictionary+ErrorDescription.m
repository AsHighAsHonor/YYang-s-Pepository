//
//  NSDictionary+ErrorDescription.m
//  trader-ios
//
//  Created by YYang1 on 16/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "NSDictionary+ErrorDescription.h"

@implementation NSDictionary (ErrorDescription)
-(NSString *)errorDescription{
//    NSMutableString *muStr = [NSMutableString string];
//
//    for (NSString *key in self.allKeys) {
//        if ([key isEqualToString:@"error"]) {
//            for (NSString *error in self[key]) {
//                [muStr appendFormat:@"%@",error];
//                [muStr appendFormat:@";"];
//            }
//            if (muStr.length > 0) {
//                [muStr deleteCharactersInRange:NSMakeRange(muStr.length-1, 1)];
//            }
//            return muStr;
//        } else if([key isEqualToString:@"NSLocalizedDescription"]){
//            [muStr appendFormat:@"%@",self[key]];
//            return muStr;
//        }else{
//            continue;
//        }
//    }
    
    return @"Unknow error";
    
}
@end
