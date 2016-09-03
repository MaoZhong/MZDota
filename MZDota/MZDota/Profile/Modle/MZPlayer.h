//
//  MZPlayer.h
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

//"account_id":198810650,
//"player_slot":0,
//"hero_id":86,
//"item_0":100,
//"item_1":123,
//"item_2":244,
//"item_3":48,
//"item_4":102,
//"item_5":232,
//"kills":6,
//"deaths":6,
//"assists":22,
//"leaver_status":0,
//"last_hits":138,
//"denies":6,
//"gold_per_min":414,
//"xp_per_min":501,
//"level":20,
//"gold":237,
//"gold_spent":17420,
//"hero_damage":13318,
//"tower_damage":487,
//"hero_healing":0,
#import <Foundation/Foundation.h>

@interface MZPlayer : NSObject

@property (nonatomic,copy) NSString *account_id;

@property (nonatomic,copy) NSString *player_slot;

@property (nonatomic,copy) NSString *hero_id;

@property (nonatomic,copy) NSString *item_0;

@property (nonatomic,copy) NSString *item_1;

@property (nonatomic,copy) NSString *item_2;

@property (nonatomic,copy) NSString *item_3;

@property (nonatomic,copy) NSString *item_4;

@property (nonatomic,copy) NSString *item_5;

@property (nonatomic,copy) NSString *kills;

@property (nonatomic,copy) NSString *deaths;

@property (nonatomic,copy) NSString *assists;

@property (nonatomic,copy) NSString *last_hits;

@property (nonatomic,copy) NSString *denies;

@property (nonatomic,copy) NSString *gold_per_min;

@property (nonatomic,copy) NSString *xp_per_min;

@property (nonatomic,copy) NSString *level;

@property (nonatomic,copy) NSString *hero_damage;

@property (nonatomic,copy) NSString *tower_damage;

@property (nonatomic,copy) NSString *hero_healing;


+ (void)getPlayerNameWithAccountId:(NSString *)account_id Success:(nullable void(^)(NSString * _Nullable responceObject))success;


+ (NSMutableArray *)playersWithArray:(NSArray *)array;

@end
