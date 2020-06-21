//
//  ZYTopicBottomView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopicBottomView.h"
#import "ZYTopicItem.h"

@interface ZYTopicBottomView ()

@property (nonatomic ,strong) UIButton *shareButton;
@property (nonatomic ,strong) UIButton *commentButton;
@property (nonatomic ,strong) UIButton *thumbsUpButton;
@property (nonatomic ,strong) UIButton *thumbsDownButton;

@end
@implementation ZYTopicBottomView
#pragma mark - 懒加载
- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [self buttonWithImage:@"mainCellShare" imageH:@"mainCellShareClick" target:self action:@selector(shareButtonClick)];
    }
    return _shareButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [self buttonWithImage:@"mainCellComment" imageH:@"mainCellCommentClick" target:self action:@selector(commentButtonClick)];
    }
    return _commentButton;
}

- (UIButton *)thumbsUpButton {
    if (!_thumbsUpButton) {
        _thumbsUpButton = [self buttonWithImage:@"mainCellDing" imageH:@"mainCellDingClick" target:self action:@selector(thumbsUpButtonClick)];
    }
    return _thumbsUpButton;
}

- (UIButton *)thumbsDownButton {
    if (!_thumbsDownButton) {
        _thumbsDownButton = [self buttonWithImage:@"mainCellCai" imageH:@"mainCellCaiClick" target:self action:@selector(thumbsDownButtonClick)];
    }
    return _thumbsDownButton;
}
#pragma mark- 创建按钮
- (UIButton *)buttonWithImage:(NSString *)image imageH:(NSString *)imageH target:(id)target action:(SEL)action {
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageH] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 按钮点击
- (void)shareButtonClick {
    
}

- (void)commentButtonClick {
    
}

- (void)thumbsUpButtonClick {
    
}

- (void)thumbsDownButtonClick {
    
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        [self addSubview:self.thumbsUpButton];
        [self.thumbsUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.25);
            make.top.height.equalTo(self);
            make.left.equalTo(self);
        }];
        [self addSubview:self.thumbsDownButton];
        [self.thumbsDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.25);
            make.top.height.equalTo(self);
            make.left.equalTo(self.thumbsUpButton.mas_right);
        }];
        [self addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.25);
            make.top.height.equalTo(self);
            make.left.equalTo(self.thumbsDownButton.mas_right);
        }];
        [self addSubview:self.commentButton];
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(0.25);
            make.top.height.equalTo(self);
            make.left.equalTo(self.shareButton.mas_right);
        }];
    }
    return self;
}

- (void)setTopicItem:(ZYTopicItem *)topicItem {
    _topicItem = topicItem;
    
    [self setUpButton:_shareButton count:topicItem.share title:@"分享"];
    [self setUpButton:_commentButton count:topicItem.comment title:@"评论"];
    [self setUpButton:_thumbsUpButton count:topicItem.thumbsUp title:@"赞"];
    [self setUpButton:_thumbsDownButton count:topicItem.thumbsDown title:@"踩"];
}

#pragma mark - 设置按钮
- (void)setUpButton:(UIButton *)btn count:(CGFloat)count title:(NSString *)title {
    NSString *str = title;
    if (count >= 10000) {
        count /= 10000;
        str = [NSString stringWithFormat:@"%.1f万",count];
    }
    else if (count > 0) {
        str = [NSString stringWithFormat:@"%.1f",count];
    }
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    [btn setTitle:str forState:UIControlStateNormal];
}
@end
