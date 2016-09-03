//
//  MZMatchHistoryTool.m
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZMatchHistoryTool.h"
#import "AFHTTPSessionManager.h"

@implementation MZMatchHistoryTool

+ (void)loadMacthHistoryWithParameters:(id)parameters success:(void (^)(NSMutableArray *))success
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"result"];
        success(dic[@"matches"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
