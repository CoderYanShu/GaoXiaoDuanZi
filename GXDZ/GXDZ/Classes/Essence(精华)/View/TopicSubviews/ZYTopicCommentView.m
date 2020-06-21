//
//  ZYTopicCommentView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopicCommentView.h"

#import "ZYTopicItem.h"
#import "ZYCommentItem.h"
#import "ZYUserItem.h"

@interface ZYTopicCommentView ()

@property (nonatomic ,strong) UIView *voiceView;
@property (nonatomic ,strong) UILabel *textLabel;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIButton *voiceButton;

@end
@implementation ZYTopicCommentView
#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = UIColor.whiteColor;
        _titleLabel.text = @"最热评论:";
    }
    return _titleLabel;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.backgroundColor = UIColor.cyanColor;
    }
    return _textLabel;
}

- (UIView *)voiceView {
    if (!_voiceView) {
        _voiceView = [[UIView alloc] init];
        _voiceView.backgroundColor = UIColor.cyanColor;
        //名称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = UIColor.grayColor;
        [_voiceView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
        }];
        //语音按钮
        _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _voiceButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _voiceButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_voiceButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _voiceButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _voiceButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_voiceButton setBackgroundImage:[UIImage imageNamed:@"play-voice-bg"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"play-voice-icon-2"] forState:UIControlStateNormal];
        [_voiceView addSubview:_voiceButton];
        [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_nameLabel.mas_height);
            make.left.mas_equalTo(_nameLabel.mas_right);
            make.top.mas_equalTo(0);
        }];
    }
    return _voiceView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.cyanColor;
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
        }];
        
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.left.right.equalTo(self);
        }];
        
        [self addSubview:self.voiceView];
        [self.voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.titleLabel.mas_height);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.left.right.equalTo(self);
        }];
        
    } return self;
}


- (void)setTopicItem:(ZYTopicItem *)topicItem {
    _topicItem = topicItem;
    
    if (topicItem.topComment.content.length) {
        _textLabel.hidden = NO;
        _voiceView.hidden = YES;
        _textLabel.text = topicItem.topComment.totalContent;
    }
    else if (topicItem.topComment.voiceTime.length) {
        _textLabel.hidden = YES;
        _voiceView.hidden = NO;
        _nameLabel.text = [NSString stringWithFormat:@"%@: ",topicItem.topComment.userItem.name];
        NSString *str = [NSString stringWithFormat:@"%@\"",topicItem.topComment.voiceTime];
        [_voiceButton setTitle:str forState:UIControlStateNormal];
    }
}
@end
