//
//  CABasicAnimation+EmptyDataImageAnimation.h
//  trader-ios
//
//  Created by YYang1 on 13/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (EmptyDataImageAnimation)
+(CABasicAnimation *)animationForEmptyDataImageBounds:(CGRect)bounds duration:(double )duration;
+(CABasicAnimation *)animationForEmptyDataImageTransformDuration:(double )duration;

@end
