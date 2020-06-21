//
//  ZYTopicCell.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopicCell.h"
#import "ZYTopicItem.h"

#import "ZYTopicTextView.h"
#import "ZYTopicPictView.h"
#import "ZYTopicVideoView.h"
#import "ZYTopicVoiceView.h"
#import "ZYTopicCommentView.h"
#import "ZYTopicBottomView.h"

@interface ZYTopicCell ()

@property (nonatomic, strong) ZYTopicTextView *textView;
@property (nonatomic, strong) ZYTopicPictView *pictView;
@property (nonatomic ,strong) ZYTopicVideoView *videoView;
@property (nonatomic ,strong) ZYTopicVoiceView *voiceView;
@property (nonatomic ,strong) ZYTopicCommentView *commentView;
@property (nonatomic ,strong) ZYTopicBottomView *bottomView;

@end

@implementation ZYTopicCell
#pragma mark- 懒加载
//- (ZYTopicTextView *)textView {
//    if (!_textView) {
//        _textView = [[ZYTopicTextView alloc] init];
//    }
//    return _textView;
//}
//
//- (ZYTopicPictView *)pictView {
//    if (!_pictView) {
//        _pictView = [[ZYTopicPictView alloc] init];
//    }
//    return _pictView;
//}
#pragma mark- 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置选中风格
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *image = [UIImage imageNamed:@"mainCellBackground"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        self.backgroundView = [[UIImageView alloc] initWithImage:image];
        
        //顶部 textView
        _textView = [[ZYTopicTextView alloc] init];
        [self.contentView addSubview:_textView];
        
        //中间(图片/视频/声音)
        // 图片
        _pictView = [[ZYTopicPictView alloc] init];
        [self.contentView addSubview:_pictView];
        // 视频
        _videoView = [[ZYTopicVideoView alloc] init];
        [self.contentView addSubview:_videoView];
        // 声音
        _voiceView = [[ZYTopicVoiceView alloc] init];
        [self.contentView addSubview:_voiceView];
        
        //最热评论
        _commentView = [[ZYTopicCommentView alloc] init];
        [self.contentView addSubview:_commentView];
        
        //底部
        _bottomView = [[ZYTopicBottomView alloc] init];
        [self.contentView addSubview:_bottomView];
    }
    return self;
}
#pragma mark- setter
- (void)setTopicItem:(ZYTopicItem *)topicItem {
    _topicItem = topicItem;
     //顶部
    _textView.topicItem = topicItem;
    _textView.frame = topicItem.textViewFrame;
    
    //中间
    if (topicItem.type == ZYTopicItemTypePict) {
        //图片
        _pictView.topicItem =  topicItem;
        _pictView.frame = topicItem.middleViewFrame;

        _pictView.hidden = NO;
        //隐藏 视频, 声音
        _videoView.hidden = YES;
        _voiceView.hidden = YES;
    }
    else if (topicItem.type == ZYTopicItemTypeVideo) {
        //视频
        _videoView.topicItem = topicItem;
        _videoView.frame = topicItem.middleViewFrame;
        
        _videoView.hidden = NO;
        
        //隐藏 图片, 声音
        _pictView.hidden = YES;
        _voiceView.hidden = YES;
    }
    else if (topicItem.type == ZYTopicItemTypeVocie) {
        _voiceView.topicItem = topicItem;
        _voiceView.frame = topicItem.middleViewFrame;
        
        _voiceView.hidden = NO;
        
        //隐藏 图片, 视频
        _pictView.hidden = YES;
        _videoView.hidden = YES;
    }
    else {
        //隐藏 图片, 视频,  声音
        _pictView.hidden = YES;
        _voiceView.hidden = YES;
        _videoView.hidden = YES;
    }
   
    //评论
    //commentView
    if (topicItem.topComment) {
        _commentView.topicItem = topicItem;
        _commentView.frame = topicItem.commentViewFrame;
        _commentView.hidden = NO;
    }
    else {
        _commentView.hidden = YES;
    }
    
    // bottomView
    _bottomView.topicItem = topicItem;
    _bottomView.frame = topicItem.bottomViewFrame;
}
@end
