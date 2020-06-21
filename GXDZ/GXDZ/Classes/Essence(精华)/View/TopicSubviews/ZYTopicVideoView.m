//
//  ZYTopicVideoView.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopicVideoView.h"
#import "ZYTopicItem.h"

@interface ZYTopicVideoView ()

@property (nonatomic ,strong) UIButton *playButton;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UILabel *durationLabel;
@property (nonatomic ,strong) UILabel *playCountLabel;

@end
@implementation ZYTopicVideoView
#pragma mark - 懒加载
- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    }
    return _playButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.textColor = UIColor.whiteColor;
        _durationLabel.backgroundColor = UIColor.blackColor;
        _durationLabel.alpha = 0.6;
    }
    return _durationLabel;
}

- (UILabel *)playCountLabel {
    if (!_playCountLabel) {
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.textColor = UIColor.whiteColor;
        _playCountLabel.backgroundColor = UIColor.blackColor;
        _playCountLabel.alpha = 0.6;
    }
    return _playCountLabel;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //imageView
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        //playCountLabel
        [self addSubview:self.playCountLabel];
        [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
        }];
        //durationLabel
        [self addSubview:self.durationLabel];
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self);
        }];
        // playButton
        [self addSubview:self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)setTopicItem:(ZYTopicItem *)topicItem {
    
    _topicItem = topicItem;
    
    NSInteger second = topicItem.videoTime % 60;
    NSInteger minute = topicItem.videoTime / 60;
    
    _durationLabel.text = [NSString stringWithFormat:@"%02li:%02li",minute,second];
    
    _playCountLabel.text = [NSString stringWithFormat:@"%@次播放",topicItem.playCount];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image]];
}

@end
