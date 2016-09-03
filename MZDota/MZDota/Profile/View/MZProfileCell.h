//
//  MZProfileCell.h
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MZMatch;
@interface MZProfileCell : UITableViewCell

@property (nonatomic,strong) MZMatch *match;

@property (nonatomic,copy) NSString *userAccountId;

+ (MZProfileCell *)cellWithTableView:(UITableView *)tableView;


@end
