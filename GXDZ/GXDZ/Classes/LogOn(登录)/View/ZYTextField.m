//
//  ZYTextField.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/16.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTextField.h"
#import "UITextField+ZYPlaceholderColor.h"

@implementation ZYTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //主题颜色
        self.tintColor = UIColor.whiteColor;
        
         //文本颜色
        self.textColor = UIColor.whiteColor;
        
        //设置输入框提示占位符颜色
        self.placeholderColor = UIColor.lightGrayColor;
        
        //清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //设置输入框提示占位符(富文本颜色)
        //[self setUpPlaceholderColor:UIColor.lightGrayColor text:@" "];
        
        //监听编辑已开始
        //[self addTarget:self action:@selector(editingBegin) forControlEvents:UIControlEventEditingDidBegin];
        
        //监听编辑已结束
        //[self addTarget:self action:@selector(editingEnd) forControlEvents:UIControlEventEditingDidEnd];
        
    }
    return self;
}

#pragma mark- 成为第一响应者
- (BOOL)becomeFirstResponder {
    self.placeholderColor = UIColor.whiteColor;
    //[self setUpPlaceholderColor:UIColor.whiteColor  text:self.placeholder];
    return [super becomeFirstResponder];
}

#pragma mark- 辞去第一响应者
- (BOOL)resignFirstResponder{
    self.placeholderColor = UIColor.lightGrayColor;
    //[self setUpPlaceholderColor:UIColor.lightGrayColor text:self.placeholder];
    return [super resignFirstResponder];
}

#pragma mark- 编辑已结束
//- (void)editingEnd {
//    [self setUpPlaceholderColor:UIColor.lightGrayColor text:self.placeholder];
//}

#pragma mark- 编辑已开始
//- (void)editingBegin {
//    [self setUpPlaceholderColor:UIColor.whiteColor  text:self.placeholder];
//}

#pragma mark- 设置输入框提示占位符(富文本)
- (void)setUpPlaceholderColor:(UIColor *)color text:(NSString *)text {
    
    NSDictionary *dict = @{NSForegroundColorAttributeName:color};
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:text attributes:dict];
    //设置输入框提示占位符
    self.attributedPlaceholder = attStr;
}
@end
