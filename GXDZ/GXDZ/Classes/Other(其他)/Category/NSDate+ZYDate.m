//
//  NSDate+ZYDate.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/21.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "NSDate+ZYDate.h"

@implementation NSDate (ZYDate)

- (BOOL)isThisYear {
    //获取当前日历
    NSCalendar *calendar = NSCalendar.currentCalendar;
    
    //获取消息接受者日期组件(年份)
    NSDateComponents *recipientComp = [calendar components:NSCalendarUnitYear fromDate:self];
    //获取当前日期组件(年份)
    NSDateComponents *currentComp  = [calendar components:NSCalendarUnitYear fromDate:NSDate.date];
    //
    return recipientComp.year == currentComp.year;
}


- (BOOL)isToday {
    return [NSCalendar.currentCalendar isDateInToday:self];
}

- (BOOL)isYesterday {
    return [NSCalendar.currentCalendar isDateInYesterday:self];
}

- (NSDateComponents *)timeDistanceWithNow {
    
    return [NSCalendar.currentCalendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:NSDate.date options:NSCalendarWrapComponents];
}
@end
