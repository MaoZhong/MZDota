//
//  MZMatchDetailCell.m
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//


#import "MZMatchDetailCell.h"
#import "MZPlayer.h"
#import "MZHeroesAndItemsTool.h"
#import "UIImageView+WebCache.h"

@interface MZMatchDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *killDeathAssist;
@property (weak, nonatomic) IBOutlet UILabel *KDA;
@property (weak, nonatomic) IBOutlet UILabel *heroDamage;
@property (weak, nonatomic) IBOutlet UILabel *towerDamage;
@property (weak, nonatomic) IBOutlet UILabel *heroHealing;
@property (weak, nonatomic) IBOutlet UILabel *xpPerMin;
@property (weak, nonatomic) IBOutlet UILabel *goldPerMin;
@property (weak, nonatomic) IBOutlet UILabel *lasthitsAndDenis;
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (nonatomic,strong) UILabel *levelLable;
@property (weak, nonatomic) IBOutlet UIImageView *item0;
@property (weak, nonatomic) IBOutlet UIImageView *item1;
@property (weak, nonatomic) IBOutlet UIImageView *item2;
@property (weak, nonatomic) IBOutlet UIImageView *item3;
@property (weak, nonatomic) IBOutlet UIImageView *item4;
@property (weak, nonatomic) IBOutlet UIImageView *item5;

@end

@implementation MZMatchDetailCell



- (UILabel *)levelLable
{
    if (!_levelLable) {
        _levelLable = [[UILabel alloc] init];
        [self.heroImageView addSubview:_levelLable];
        CGFloat w = 14;
        CGFloat h = 14;
        CGFloat x = self.heroImageView.frame.size.width - w;
        CGFloat y = self.heroImageView.frame.size.height - h;
        _levelLable.frame = CGRectMake(x, y, w, h);
        _levelLable.textAlignment = NSTextAlignmentCenter;
        _levelLable.font = [UIFont systemFontOfSize:11];
        _levelLable.textColor = [UIColor whiteColor];
    }
    return _levelLable;
}

+(MZMatchDetailCell *)matchDetailWithTableView:(UITableView *)tableView
{
    static NSString *reusedId = @"matchDetail";
    MZMatchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MZMatchDetailCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return  cell;
}

- (void)setPlayer:(MZPlayer *)player
{
    _player = player;
    
    [MZPlayer getPlayerNameWithAccountId:player.account_id Success:^(NSString * _Nullable responceObject) {
        if ([responceObject isEqualToString:@"匿名玩家"]) {
            self.accountId.text = responceObject;
        }else{
            self.accountId.text = [self replaceUnicode:responceObject];
        }
    }];
    NSString *KDA = [NSString stringWithFormat:@"KDA:%.2f",(player.kills.floatValue + player.assists.floatValue)/player.deaths.floatValue];
    self.KDA.text = KDA;
    NSString *killDeathAssist = [NSString stringWithFormat:@"%@/%@/%@",player.kills,player.deaths,player.assists];
    self.killDeathAssist.text = killDeathAssist;
    NSString *heroDamage = [NSString stringWithFormat:@"英雄伤害:%@",player.hero_damage];
    self.heroDamage.text = heroDamage;
    NSString *towerDamage = [NSString stringWithFormat:@"建筑伤害:%@",player.tower_damage];
    self.towerDamage.text = towerDamage;
    NSString *heroHealing = [NSString stringWithFormat:@"英雄治疗:%@",player.hero_healing];
    self.heroHealing.text = heroHealing;
    NSString *xpPerMin = [NSString stringWithFormat:@"每分钟经验:%@",player.xp_per_min];
    self.xpPerMin.text = xpPerMin;
    NSString *goldPerMin = [NSString stringWithFormat:@"每分钟金钱:%@",player.gold_per_min];
    self.goldPerMin.text = goldPerMin;
    NSString *lasthitsAndDenies = [NSString stringWithFormat:@"正/反补:%@/%@",player.last_hits,player.denies];
    self.lasthitsAndDenis.text = lasthitsAndDenies;
    self.levelLable.text = player.level;
    [self loadHeroImageWithHeroId:player.hero_id];
    [self loadItemImageWithImageView:self.item0 itemString:player.item_0];
    [self loadItemImageWithImageView:self.item1 itemString:player.item_1];
    [self loadItemImageWithImageView:self.item2 itemString:player.item_2];
    [self loadItemImageWithImageView:self.item3 itemString:player.item_3];
    [self loadItemImageWithImageView:self.item4 itemString:player.item_4];
    [self loadItemImageWithImageView:self.item5 itemString:player.item_5];

   }

- (void)loadHeroImageWithHeroId:(NSString *)hero_id
{
    [MZHeroesAndItemsTool getHeroNameWithHeroId:hero_id success:^(NSString * _Nullable responceObject) {
        NSString *str = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/heroes/%@_lg.png",responceObject];
        NSURL *url = [NSURL URLWithString:str];
        [self.heroImageView sd_setImageWithURL:url placeholderImage:nil];
    }];

}

- (void)loadItemImageWithImageView:(UIImageView *)imageView itemString:(NSString *)itemString
{
    if ([itemString isEqualToString:@"0"]) {
        imageView.image = nil;
        return;
    }
    [MZHeroesAndItemsTool getItemNameWithItemId:itemString success:^(NSString * _Nullable responceObject) {
        NSString *str = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",responceObject];
        NSURL *url = [NSURL URLWithString:str];
        [imageView sd_setImageWithURL:url placeholderImage:nil];

    }];
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
