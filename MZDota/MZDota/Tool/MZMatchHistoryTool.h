//
//  MZMatchHistoryTool.h
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZMatchHistoryTool : NSObject

+ (void)loadMacthHistoryWithParameters:(id _Nonnull)parameters success:(nullable void(^)(NSMutableArray * _Nullable responceObject))success;

@end
