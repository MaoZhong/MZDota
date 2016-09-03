//
//  MZHeroesAndItemsCacheTool.m
//  MZDota
//
//  Created by 毛众 on 16/8/24.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZHeroesAndItemsCacheTool.h"
#import "FMDatabase.h"

@implementation MZHeroesAndItemsCacheTool

static FMDatabase *_db;

+(void)initialize
{
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"heroes.sqlite"];
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    [_db executeUpdate:@"create table if not exists t_heroes (id integer primary key autoincrement,name text,idstr text,item text);"];

}

+(void)saveHeroesWithArray:(NSArray *)heroes
{
    for (NSDictionary *dic in heroes) {
        NSString *name = dic[@"name"];
        NSString *idstr = [dic[@"id"] description];
        NSString *item = @"hero";
        [_db executeUpdate:@"insert into t_heroes (name,idstr,item) values(?,?,?)",name,idstr,item];
    }

}

+ (NSString *)getHeroNameWithHeroId:(NSString *)hero_id
{
    NSString *sql = [NSString stringWithFormat:@"select * from t_heroes where idstr = '%@' and item = 'hero';",hero_id];
    FMResultSet *set = [_db executeQuery:sql];
    while ([set next]) {
        NSString *heroName = [set stringForColumn:@"name"];
        NSRange range = [heroName rangeOfString:@"hero_"];
        heroName = [heroName substringFromIndex:range.location + range.length];
        return heroName;

    }
    return nil;
}

+ (void)saveItemsWithArray:(NSArray *)items
{
    for (NSDictionary *dic in items) {
        NSString *name = dic[@"name"];
        NSString *idstr = [dic[@"id"] description];
        NSString *item = @"item";
        [_db executeUpdate:@"insert into t_heroes (name,idstr,item) values(?,?,?)",name,idstr,item];
    }

}

+ (NSString *)getItemNameWithItemId:(NSString *)item_id
{
    NSString *sql = [NSString stringWithFormat:@"select * from t_heroes where idstr = '%@' and item = 'item';",item_id];
    FMResultSet *set = [_db executeQuery:sql];
    while ([set next]) {
        NSString *itemName = [set stringForColumn:@"name"];
        NSRange range = [itemName rangeOfString:@"item_"];
        itemName = [itemName substringFromIndex:range.location + range.length];
        return itemName;
        
    }
    return nil;

}
@end
