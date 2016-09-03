//
//  MZHeroesAndItemsTool.m
//  MZDota
//
//  Created by 毛众 on 16/8/24.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZHeroesAndItemsTool.h"
#import "AFHTTPSessionManager.h"
#import "MZHeroesAndItemsCacheTool.h"

@implementation MZHeroesAndItemsTool

+ (void)getHeroNameWithHeroId:(NSString *)hero_id success:(void (^)(NSString * _Nullable))success
{
    NSString *heroName = [MZHeroesAndItemsCacheTool getHeroNameWithHeroId:hero_id];
    if (heroName) {
        success(heroName);
        
        return;
    }
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"8E8AD634520E14C4844490058920829D";
    [mgr GET:@"https://api.steampowered.com/IEconDOTA2_570/GetHeroes/V001" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        [MZHeroesAndItemsCacheTool saveHeroesWithArray:result[@"heroes"]];
        for (NSDictionary *dic in result[@"heroes"]) {
                if (hero_id.intValue == [dic[@"id"] intValue]) {
                NSRange range = [dic[@"name"] rangeOfString:@"hero_"];
                
                NSString *name = [dic[@"name"] substringFromIndex:range.location + range.length];
                
                success(name);
                return ;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+(void)getItemNameWithItemId:(NSString *)item_id success:(void (^)(NSString * _Nullable))success
{
  
    NSString *itemName = [MZHeroesAndItemsCacheTool getItemNameWithItemId:item_id];
    if (itemName) {
        success(itemName);
        return;
    }

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"8E8AD634520E14C4844490058920829D";
    [mgr GET:@"https://api.steampowered.com/IEconDOTA2_570/GetGameItems/V001" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        [MZHeroesAndItemsCacheTool saveItemsWithArray:result[@"items"]];
        for (NSDictionary *dic in result[@"items"]) {
            if (item_id.intValue == [dic[@"id"] intValue]) {
                NSRange range = [dic[@"name"] rangeOfString:@"item_"];
                
                NSString *name = [dic[@"name"] substringFromIndex:range.location + range.length];
                
                success(name);
                return ;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

@end
