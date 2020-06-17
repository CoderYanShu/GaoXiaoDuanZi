//
//  UITextField+ZYPlaceholderColor.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "UITextField+ZYPlaceholderColor.h"

@implementation UITextField (ZYPlaceholderColor)


- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    if (self.placeholder.length == 0) self.placeholder = @" ";
    //placeholderLabel 是懒加载 self.placeholder 有值,才能获取
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    placeholderLabel.textColor = placeholderColor;
    
}

- (UIColor *)placeholderColor {
    
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    return placeholderLabel.textColor;
    
}
@end
