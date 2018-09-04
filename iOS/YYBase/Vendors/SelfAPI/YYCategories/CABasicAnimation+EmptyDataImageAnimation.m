//
//  CABasicAnimation+EmptyDataImageAnimation.m
//  trader-ios
//
//  Created by YYang1 on 13/5/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "CABasicAnimation+EmptyDataImageAnimation.h"

@implementation CABasicAnimation (EmptyDataImageAnimation)
+(CABasicAnimation *)animationForEmptyDataImageBounds:(CGRect)bounds duration:(double )duration{
    CABasicAnimation *animation = [self animationWithKeyPath:@"bounds"];
    animation.duration = duration;
    animation.cumulative = NO;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = [NSValue valueWithCGRect:bounds];
    return animation;
}

+(CABasicAnimation *)animationForEmptyDataImageTransformDuration:(double )duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = duration;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
@end
