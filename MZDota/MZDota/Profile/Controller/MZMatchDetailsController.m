//
//  MZMatchDetailsController.m
//  MZDota
//
//  Created by 毛众 on 16/8/22.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZMatchDetailsController.h"
#import "MZMatchDetailsTool.h"
#import "MZMatchDetail.h"
#import "MJExtension.h"
#import "MZPlayer.h"
#import "MZMatchDetailCell.h"
#import "MBProgressHUD.h"

@interface MZMatchDetailsController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) MZMatchDetail *matchDetail;

@property (nonatomic,strong) NSMutableArray *players;
@end

@implementation MZMatchDetailsController

- (NSMutableArray *)players
{
    if (!_players) {
        _players = [NSMutableArray array];
    }
    return _players;
}

- (MZMatchDetail *)matchDetail
{
    if (!_matchDetail) {
        _matchDetail = [[MZMatchDetail alloc] init];
    }
    return _matchDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];

    self.navigationItem.leftBarButtonItem = leftbtn;
    self.navigationItem.title = @"比赛详情";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor whiteColor];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
}


- (void)setMatch_id:(NSString *)match_id
{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"key"] = @"8E8AD634520E14C4844490058920829D";
        params[@"match_id"] = match_id;
            [MZMatchDetailsTool matchDetailsWithParameters:params success:^(NSDictionary * _Nullable responceObject) {
                self.matchDetail = [MZMatchDetail mj_objectWithKeyValues:responceObject];
                self.players = [MZPlayer playersWithArray:self.matchDetail.players];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
                [self.view addSubview:self.tableView];
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                self.tableView.rowHeight = 170;

            }];
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count/2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZMatchDetailCell *cell = [MZMatchDetailCell matchDetailWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.player = self.players[indexPath.row];
        cell.accountId.textColor = [UIColor greenColor];

    }else{
        cell.player = self.players[indexPath.row + 5];
        cell.accountId.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    UILabel *teamLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [headerView addSubview:teamLable];
    teamLable.textAlignment = NSTextAlignmentCenter;
      UILabel *detailLable = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, headerView.bounds.size.width - 120, 40)];
    [headerView addSubview:detailLable];
    detailLable.textAlignment = NSTextAlignmentRight;
    NSString *detailLableText;
    if (section == 0) {
        teamLable.text = self.matchDetail.radiant_win;
        teamLable.backgroundColor = [UIColor greenColor];
        detailLableText = [NSString stringWithFormat:@"杀敌%@",self.matchDetail.radiant_score];
    }else{
        teamLable.text = self.matchDetail.dire_win;
        teamLable.backgroundColor = [UIColor redColor];
        detailLableText = [NSString stringWithFormat:@"杀敌%@",self.matchDetail.dire_score];

    }
    detailLable.text = detailLableText;

  
    return headerView;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
