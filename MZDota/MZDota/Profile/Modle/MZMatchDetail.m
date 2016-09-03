//
//  MZMatchDetail.m
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZMatchDetail.h"
#import "MJExtension.h"
#import "MZPlayer.h"

@implementation MZMatchDetail

- (NSString *)radiant_win
{
    if ([_radiant_win isEqualToString:@"0"]) {
        return @"天辉失败";
    }
    return @"天辉胜利";
}

- (NSString *)dire_win
{
    if ([_radiant_win isEqualToString:@"0"]) {
        return @"夜魇胜利";
    }
    return @"夜魇失败";
}

@end
