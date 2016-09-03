//
//  MZHeroesAndItemsTool.h
//  MZDota
//
//  Created by 毛众 on 16/8/24.
//  Copyright © 2016年 134. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZHeroesAndItemsTool : NSObject


+ (void)getHeroNameWithHeroId:(NSString * _Nonnull)hero_id success:(nullable void(^)(NSString *_Nullable responceObject))success;

+ (void)getItemNameWithItemId:(NSString * _Nonnull)item_id success:(nullable void(^)(NSString *_Nullable responceObject))success;


@end
