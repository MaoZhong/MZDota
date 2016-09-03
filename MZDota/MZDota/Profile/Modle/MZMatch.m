//
//  MZMatch.m
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZMatch.h"
#import "MJExtension.h"
#import "NSDate+date.h"

@implementation MZMatch

+(NSMutableArray *)matchesWithArray:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        MZMatch *match = [MZMatch mj_objectWithKeyValues:dic];
        [tempArray addObject:match];
    }
    return tempArray;
}

- (NSString *)start_time
{
    NSString *timeStamp2 = _start_time;
    long long int date1 = (long long int)[timeStamp2 intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];

    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:date2 toDate:now options:0];
    
    if ([date2 isThisYear]) { // 今年
        if ([date2 isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date2];
        } else if ([date2 isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date2];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:date2];
    }

}
@end
