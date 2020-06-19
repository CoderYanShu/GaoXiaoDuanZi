//
//  ZYCollectionView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/17.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYFooterView.h"

@implementation ZYFooterView

- (UICollectionViewFlowLayout *)flowLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //列数
    _columns = 4;
    
    //白边宽
    _margin = 1;
    
    //item 宽(高) (屏幕宽 - 所有白边宽之和) / 列数
    CGFloat itemWH = (kSCREEN_WIDTH - (_columns - 1) * _margin) / _columns;
    
    //item 最小行间距
    flowLayout.minimumLineSpacing = _margin;
    
    //item 最小(列)间距
    flowLayout.minimumInteritemSpacing = _margin;
    
    //item 大小
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    
    return flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:self.flowLayout]) {
        
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

@end
