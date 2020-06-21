//
//  NSDate+ZYDate.h
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZYDate)

- (BOOL)isThisYear;

- (BOOL)isToday;

- (BOOL)isYesterday;

- (NSDateComponents *)timeDistanceWithNow;

@end

NS_ASSUME_NONNULL_END
