//
//  ViewController.m
//  JWMenuView
//
//  Created by Jarvi on 16/7/6.
//  Copyright © 2016年 Jarvi. All rights reserved.
//

#import "ViewController.h"
#import "JWMenuView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *menuButton;     /**< <#name#> */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)menuButtonAction
{
    [JWMenuView showWithImageArray:@[@"menu_icon_chat",@"menu_icon_phone",@"menu_icon_folder",@"menu_icon_scan",@"menu_icon_lbs"] titleArray:@[@"多人聊天",@"语音电话",@"传文件",@"扫一扫",@"找朋友"] itemAction:^(NSInteger row) {
        NSLog(@"%ld",row);
    }];
}

- (UIButton *)menuButton
{
    if(_menuButton == nil)
    {
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _menuButton.frame = CGRectMake(0, 0, 40, 40);
        [_menuButton setImage:[UIImage imageNamed:@"nav_icon_r_add"] forState:UIControlStateNormal];
        [_menuButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        [_menuButton addTarget:self action:@selector(menuButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
