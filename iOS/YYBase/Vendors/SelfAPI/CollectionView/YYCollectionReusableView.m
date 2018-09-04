//
//  YYCollectionReusableView.m
//  trader-ios
//
//  Created by YYang1 on 2/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import "YYCollectionReusableView.h"
#import "YYCollectionViewLayoutAttributes.h"
@implementation YYCollectionReusableView
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[YYCollectionViewLayoutAttributes class]]) {
        YYCollectionViewLayoutAttributes *attr = (YYCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}
@end
