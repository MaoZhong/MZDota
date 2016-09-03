//
//  MZMatchDetailsTool.m
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZMatchDetailsTool.h"
#import "AFHTTPSessionManager.h"

@implementation MZMatchDetailsTool

+ (void)matchDetailsWithParameters:(id)parameters success:(void (^)(NSDictionary *))success
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject[@"result"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
