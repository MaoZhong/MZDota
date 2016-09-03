//
//  MZMatchDetailsTool.h
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZMatchDetailsTool : NSObject

+ (void)matchDetailsWithParameters:(id _Nonnull)parameters success:(nullable void(^)(NSDictionary * _Nullable responceObject))success;

@end
