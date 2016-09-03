//
//  MZTabBarController.m
//  MZDota
//
//  Created by 毛众 on 16/8/20.
//  Copyright © 2016年 134. All rights reserved.
//

#import "MZTabBarController.h"
#import "MZNavigationController.h"
#import "MZProfileViewController.h"
#import "MZDataViewController.h"
#import "MZDiscoverViewController.h"
#import "MZForecastViewController.h"
#import "MZLiveViewController.h"

@interface MZTabBarController ()

@end

@implementation MZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpChildViewController];
}

- (void)setUpChildViewController
{
    MZProfileViewController *profileVc = [[MZProfileViewController alloc] init];
    [self setUpChildController:profileVc withImage:[UIImage imageNamed:@"tabbar_icon_me_normal"] withSelectedImage:[UIImage imageNamed:@"tabbar_icon_me_highlight"] withTitle:@"我"];
    MZDataViewController *dataVc = [[MZDataViewController alloc] init];
    [self setUpChildController:dataVc withImage:[UIImage imageNamed:@"tabbar_icon_news_normal"] withSelectedImage:[UIImage imageNamed:@"tabbar_icon_news_highlight"] withTitle:@"数据"];
    MZForecastViewController *forecastVc = [[MZForecastViewController alloc] init];
    [self setUpChildController:forecastVc withImage:[UIImage imageNamed:@"tabbar_icon_reader_normal"] withSelectedImage:[UIImage imageNamed:@"tabbar_icon_reader_highlight"] withTitle:@"竞猜"];
    MZDiscoverViewController *discoverVc = [[MZDiscoverViewController alloc] init];
    [self setUpChildController:discoverVc withImage:[UIImage imageNamed:@"tabbar_icon_found_normal"] withSelectedImage:[UIImage imageNamed:@"tabbar_icon_found_highlight"] withTitle:@"发现"];
    MZLiveViewController *liveVc = [[MZLiveViewController alloc] init];
    [self setUpChildController:liveVc withImage:[UIImage imageNamed:@"tabbar_icon_media_normal"] withSelectedImage:[UIImage imageNamed:@"tabbar_icon_media_highlight"] withTitle:@"直播"];
}

- (void)setUpChildController:(UIViewController *)childController withImage:(UIImage *)image withSelectedImage:(UIImage *)selectedImage withTitle:(NSString *)title
{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = image;
    childController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *att = [[NSMutableDictionary alloc] init];
    att[NSForegroundColorAttributeName] = [UIColor redColor];
    [childController.tabBarItem setTitleTextAttributes:att forState:UIControlStateSelected];
    MZNavigationController *nav = [[MZNavigationController alloc] initWithRootViewController:childController];
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:221/255.0 green:50/255.0 blue:55/255.0 alpha:1];
    childController.navigationItem.title = title;
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    nav.navigationBar.titleTextAttributes = att;
     childController.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:nav];
    
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
