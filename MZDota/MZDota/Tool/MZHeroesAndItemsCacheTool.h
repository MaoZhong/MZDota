//
//  MZHeroesAndItemsCacheTool.h
//  MZDota
//
//  Created by 毛众 on 16/8/24.
//  Copyright © 2016年 134. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZHeroesAndItemsCacheTool : NSObject

+ (void)saveHeroesWithArray:(NSArray *)heroes;

+ (NSString *)getHeroNameWithHeroId:(NSString *)hero_id;

+ (void)saveItemsWithArray:(NSArray *)items;

+ (NSString *)getItemNameWithItemId:(NSString *)item_id;

@end
