//
//  ZYTopicItem.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/20.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//margin

#define kTOPIC_MARGIN 10

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ZYTopicItemTypeAll = 1,
    ZYTopicItemTypeText = 29,
    ZYTopicItemTypeVideo = 41,
    ZYTopicItemTypeVocie = 31,
    ZYTopicItemTypePict = 10
} ZYTopicItemType;

@class ZYCommentItem;

NS_ASSUME_NONNULL_BEGIN

/// 发帖模型
@interface ZYTopicItem : NSObject

/// type 1：全部 10：图片(默认) 29：段子 31：音频 41：视频
@property (nonatomic ,assign) ZYTopicItemType type;

// textView
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *time;
@property (nonatomic ,strong) NSString *text;

// pictView videoView voiceView
@property (nonatomic ,strong) NSString *image;
@property (nonatomic ,strong) UIImage *localImage;

// pictView
@property (nonatomic ,assign) BOOL isGif;
@property (nonatomic ,assign) CGFloat width;
@property (nonatomic ,assign) CGFloat height;
@property (nonatomic ,assign) BOOL isBigPict;

// videoView voiceView
@property (nonatomic ,strong) NSString *playCount;

//videoView
@property (nonatomic ,strong) NSString *videoUrl;
@property (nonatomic ,assign) NSInteger videoTime;

//voiceView
@property (nonatomic ,strong) NSString *voiceUrl;
@property (nonatomic ,assign) NSInteger voiceTime;

//commentView
@property (nonatomic ,strong) ZYCommentItem *topComment;
@property (nonatomic ,strong) NSMutableArray *comments;

// bottomView
@property (nonatomic ,assign) CGFloat share;
@property (nonatomic ,assign) CGFloat comment;
@property (nonatomic ,assign) CGFloat thumbsUp;
@property (nonatomic ,assign) CGFloat thumbsDown;

//cellHeight  subviewFrames
@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, readonly) CGRect textViewFrame;
@property (nonatomic, readonly) CGRect middleViewFrame;
@property (nonatomic, readonly) CGRect commentViewFrame;
@property (nonatomic ,readonly) CGRect bottomViewFrame;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)topicItemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
