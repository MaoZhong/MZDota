//
//  MZProfileCell.m
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZProfileCell.h"
#import "MZMatch.h"
#import "MZUser.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"

@interface MZProfileCell()

@property (weak, nonatomic) IBOutlet UILabel *startTime;

@property (weak, nonatomic) IBOutlet UILabel *matchId;

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@end

@implementation MZProfileCell

+ (MZProfileCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *reusedId = @"match";
    MZProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MZProfileCell" owner:nil options:nil] lastObject];
    }
  
    return cell;
}

- (void)setMatch:(MZMatch *)match
{
    _match = match;
    NSString *start_time = [NSString stringWithFormat:@"比赛时间：%@",match.start_time];
    self.startTime.text = start_time;
    NSString *match_id = [NSString stringWithFormat:@"比赛编号：%@",match.match_id];
    self.matchId.text = match_id;

}

- (void)setUserAccountId:(NSString *)userAccountId
{
    [self getUserInfoWithAccountId:(NSString *)userAccountId Success:^(MZUser * _Nullable user) {
        self.userName.text = [self replaceUnicode:user.userName];
        NSURL *url = [NSURL URLWithString:user.userIcon];
        [self.userIcon sd_setImageWithURL:url placeholderImage:nil];
    }];

}

- (void)getUserInfoWithAccountId:(NSString *)accountId Success:(void(^)(MZUser * _Nullable user))success
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"8E8AD634520E14C4844490058920829D";
    long long aId = accountId.longLongValue;
    NSString *str = [NSString stringWithFormat:@"%lld",aId + 76561197960265728];
    params[@"steamids"] = str;
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"response"];
        NSArray *array = dic[@"players"];
        MZUser *user = [[MZUser alloc] init];
        user.userIcon = array[0][@"avatar"];
        user.userName = array[0][@"personaname"];
        success(user);
//        if (!array.count) {
//            NSString *str = @"匿名玩家";
//            success(str);
//            return;
//        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
