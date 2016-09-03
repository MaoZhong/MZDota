//
//  MZPlayer.m
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

//@property (nonatomic,copy) NSString *last_hits;
//
//@property (nonatomic,copy) NSString *denies;
//
//@property (nonatomic,copy) NSString *gold_per_min;
//
//@property (nonatomic,copy) NSString *xp_per_min;
//
//@property (nonatomic,copy) NSString *level;
//
//@property (nonatomic,copy) NSString *hero_damage;
//
//@property (nonatomic,copy) NSString *tower_damage;
//
//@property (nonatomic,copy) NSString *hero_healing;


#import "MZPlayer.h"
#import "MJExtension.h"
#import "AFHTTPSessionManager.h"

@implementation MZPlayer

+ (NSMutableArray *)playersWithArray:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        MZPlayer *player = [MZPlayer mj_objectWithKeyValues:dic];
        [tempArray addObject:player];
    }
    return tempArray;
}

+ (void)getPlayerNameWithAccountId:(NSString *)account_id Success:(void (^)(NSString * _Nullable))success
{
    NSString *steamids = [NSString stringWithFormat:@"%ld",account_id.intValue + 76561197960265728];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"steamids"] = steamids;
    params[@"key"] = @"8E8AD634520E14C4844490058920829D";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"response"];
        NSArray *array = dic[@"players"];
        if (!array.count) {
            NSString *str = @"匿名玩家";
            success(str);
            return;
        }

        NSString *str = array[0][@"personaname"];
        success(str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}


@end
