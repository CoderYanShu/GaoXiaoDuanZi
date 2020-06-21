//
//  ZYTopicItem.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYTopicItem.h"
#import "ZYCommentItem.h"

@implementation ZYTopicItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _type = [dict[@"type"] integerValue];
        
        _name = dict[@"name"];
        _text = dict[@"text"];
        _time = dict[@"create_time"];
        _icon = dict[@"profile_image"];
        
        _image = dict[@"image0"];
        
        _isGif = [dict[@"is_gif"] boolValue];
        _width = [dict[@"width"] floatValue];
        _height = [dict[@"height"] floatValue];
        
        _playCount = dict[@"playcount"];
        
        _videoUrl = dict[@"videouri"];
        _videoTime = [dict[@"videotime"] integerValue];
        
        _voiceUrl = dict[@"voiceuri"];
        _voiceTime = [dict[@"voicetime"] integerValue];
        
        
        NSArray *tmpArr = dict[@"top_cmt"];
        if (tmpArr.count) {
            for (NSDictionary *dict in tmpArr) {
                [_comments addObject:[ZYCommentItem commentItemWithDict:dict]];
            }
            _topComment = self.comments.firstObject;
        }
        
        
        
        _share = [dict[@"repost"] floatValue];
        _comment = [dict[@"comment"] floatValue];
        _thumbsUp = [dict[@"ding"] floatValue];
        _thumbsDown = [dict[@"cai"] floatValue];
        
        
        [self cellHeightAndSubviewFrames];
    }
    return self;
}

+ (instancetype)topicItemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


- (void)cellHeightAndSubviewFrames {
    
    CGFloat x = kTOPIC_MARGIN;
    CGFloat width = kSCREEN_WIDTH - kTOPIC_MARGIN * 2;
    /////////////////////////textViewFrame////////////////////////////////
    //textViewFrame    iconView.height = 40
    //文本 Y
    CGFloat textY = 40 + kTOPIC_MARGIN * 2;
    //文本 H
    CGFloat textH = [self textHeightWithText:_text textWidth:width fontSize:15];
    //文本视图 H
    CGFloat textViewH = textY + textH;
    //文本视图 Y
    CGFloat textViewY = kTOPIC_MARGIN;
    //文本视图 frame
    _textViewFrame = CGRectMake(x, textViewY, width, textViewH);
    //cell H
    _cellHeight = CGRectGetMaxY(_textViewFrame) + kTOPIC_MARGIN;
    ///////////////////////////middleViewFrame//////////////////////////////////
    //判断是否为段子类型(无图片)
    if (_type != ZYTopicItemTypeText) {
        //(图片/视频/声音)视图 Y
        CGFloat pictViewY = _cellHeight;
         //(图片/视频/声音)视图 H
        CGFloat pictViewH = width / _width * _height;
        //判断图片是否高于屏幕
        if (pictViewH > kSCREEN_HEIGHT) {
            pictViewH = 300;
            _isBigPict = YES;
        }
        //(图片/视频/声音)视图 frame
        _middleViewFrame = CGRectMake(x, pictViewY, width, pictViewH);
        //cell H
        _cellHeight = CGRectGetMaxY(_middleViewFrame) + kTOPIC_MARGIN;
    }
    ////////////////////////commentViewFrame///////////////////////////
    CGFloat commentViewH = 0;
    CGFloat commentViewY = _cellHeight;
    if (_topComment) {
        CGFloat titleH = [self textHeightWithText:@"最热评论" textWidth:width fontSize:17];
        //当评论是语音评论是高度= 两行 label 的高度
        commentViewH = 2 * titleH;
        
        //判断是否是文字评论
        if (_topComment.content.length) {
            CGFloat contentH = [self textHeightWithText:_topComment.totalContent textWidth:width fontSize:17];
            commentViewH = titleH + contentH;
        }
        //评论视图 frame
        _commentViewFrame = CGRectMake(x, commentViewY,width, commentViewH);
        //cell H
        _cellHeight = CGRectGetMaxY(_commentViewFrame) + kTOPIC_MARGIN;
    }
    ////////////////////////////////bottomViewFrame///////////////////////////////////////
    CGFloat bottomViewH = 30;
    CGFloat bottomViewY = _cellHeight;
    
    //bottomViewFrame
    _bottomViewFrame = CGRectMake(x, bottomViewY,width, bottomViewH);
     //cell H
    _cellHeight = _cellHeight = CGRectGetMaxY(_bottomViewFrame) + kTOPIC_MARGIN;
}


- (CGFloat)textHeightWithText:(NSString *)text textWidth:(CGFloat) width fontSize:(CGFloat)size {
    
    return  [text boundingRectWithSize:CGSizeMake(width , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size.height;
}
@end
