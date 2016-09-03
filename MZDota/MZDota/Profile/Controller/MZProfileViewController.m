//
//  MZProfileViewController.m
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZProfileViewController.h"
#import "MZMatchHistoryTool.h"
#import "MZMatch.h"
#import "MZMatchDetailsTool.h"
#import "MZPlayer.h"
#import "MZProfileCell.h"
#import "MZMatchDetailsController.h"
#import "MZNavigationController.h"
#import "MJRefresh.h"

@interface MZProfileViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) NSMutableArray *matches;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSString *account_id;

@end

@implementation MZProfileViewController

- (NSMutableArray *)matches
{
    if (!_matches) {
        _matches = [NSMutableArray array];
    }
    return _matches;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"MZDOTA";
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 32)];
    searchBar.placeholder = @"请输入16位数字ID";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:searchBar];
    searchBar.delegate = self;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
  
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMacthHistory)];
    self.account_id = @"136716865";
    [self.tableView.mj_header beginRefreshing];
   
  
}

- (void)loadMacthHistory
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"8E8AD634520E14C4844490058920829D";
    params[@"account_id"] = self.account_id;
    [MZMatchHistoryTool loadMacthHistoryWithParameters:params success:^(NSMutableArray * _Nullable responceObject) {
       self.matches = [MZMatch matchesWithArray:responceObject];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
         }];
}





#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.matches.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MZProfileCell *cell = [MZProfileCell cellWithTableView:tableView];
    cell.match = self.matches[indexPath.row];
    cell.userAccountId = self.account_id;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZMatchDetailsController *detailsVc = [[MZMatchDetailsController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailsVc];
    [self presentViewController:nav animated:YES completion:^{
        
        detailsVc.match_id = [self.matches[indexPath.row] match_id];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark searchBar delegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.account_id = searchBar.text;
    [self.tableView.mj_header beginRefreshing];
    
    [self.view endEditing:YES];

}












@end
