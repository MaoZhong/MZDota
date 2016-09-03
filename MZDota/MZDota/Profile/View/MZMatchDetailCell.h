//
//  MZMatchDetailCell.h
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZPlayer;

@interface MZMatchDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *accountId;
@property (nonatomic,strong) MZPlayer *player;


+ (MZMatchDetailCell *)matchDetailWithTableView:(UITableView *)tableView;


@end
