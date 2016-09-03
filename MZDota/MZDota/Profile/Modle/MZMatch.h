//
//  MZMatch.h
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZMatch : NSObject

@property (nonatomic,copy) NSString *match_id;

@property (nonatomic,strong) NSArray *players;

@property (nonatomic,copy) NSString *start_time;



+ (NSMutableArray *)matchesWithArray:(NSArray *)array;

@end
