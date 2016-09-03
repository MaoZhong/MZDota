//
//  MZMatchDetail.h
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZMatchDetail : NSObject

@property (nonatomic,copy) NSString *match_id;

@property (nonatomic,strong) NSArray *players;

@property (nonatomic,copy) NSString *start_time;

@property (nonatomic,copy) NSString *radiant_win;

@property (nonatomic,copy) NSString *duration;

@property (nonatomic,copy) NSString *game_mode;

@property (nonatomic,copy) NSString *radiant_score;

@property (nonatomic,copy) NSString *dire_score;

@property (nonatomic,copy) NSString *dire_win;

@end
