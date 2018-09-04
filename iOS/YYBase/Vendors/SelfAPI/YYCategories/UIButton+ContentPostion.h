//
//  UIButton+ContentPostion.h
//  trader-ios
//
//  Created by YYang1 on 27/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSImagePositionType) {
    SSImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    SSImagePositionTypeRight,  //图片在右，标题在左
    SSImagePositionTypeTop,    //图片在上，标题在下
    SSImagePositionTypeBottom  //图片在下，标题在上
};

typedef NS_ENUM(NSInteger, SSEdgeInsetsType) {
    SSEdgeInsetsTypeTitle,//标题
    SSEdgeInsetsTypeImage//图片
};

typedef NS_ENUM(NSInteger, SSMarginType) {
    SSMarginTypeTop         ,
    SSMarginTypeBottom      ,
    SSMarginTypeLeft        ,
    SSMarginTypeRight       ,
    SSMarginTypeTopLeft     ,
    SSMarginTypeTopRight    ,
    SSMarginTypeBottomLeft  ,
    SSMarginTypeBottomRight
};

@interface UIButton (ContentPostion)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
 2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */
- (void)setImagePositionWithType:(SSImagePositionType)type spacing:(CGFloat)spacing;

/**
 *  按钮只设置了title or image，该方法可以改变它们的位置
 *
 *  @param edgeInsetsType <#edgeInsetsType description#>
 *  @param marginType     <#marginType description#>
 *  @param margin         <#margin description#>
 */
- (void)setEdgeInsetsWithType:(SSEdgeInsetsType)edgeInsetsType marginType:(SSMarginType)marginType margin:(CGFloat)margin;

@end
