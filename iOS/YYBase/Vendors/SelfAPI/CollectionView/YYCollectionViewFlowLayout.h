//
//  YYCollectionViewFlowLayout.h
//  trader-ios
//
//  Created by YYang1 on 2/6/18.
//  Copyright © 2018 Trader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section;

@end

@interface YYCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end
