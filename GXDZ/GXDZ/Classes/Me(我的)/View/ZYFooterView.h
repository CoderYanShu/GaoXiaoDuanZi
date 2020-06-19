//
//  ZYCollectionView.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYFooterView : UICollectionView

@property (nonatomic, readonly) CGFloat margin;
@property (nonatomic, readonly) NSInteger columns;
@property (nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;

@end

NS_ASSUME_NONNULL_END
