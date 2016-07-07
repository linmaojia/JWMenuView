//
//  JWMenuView.m
//  hysc
//
//  Created by Jarvi on 16/7/5.
//  Copyright © 2016年 Jarvi. All rights reserved.
//

#import "JWMenuView.h"
/**
 *  动画时间
 */
static float const ANIMATION_TIME = .2;

@interface JWMenuView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *bgImageView;     /**< 白色气泡背景 */
@property (nonatomic, strong) NSArray *imageArray;     /**< 图片数组 */
@property (nonatomic, strong) NSArray *titleArray;     /**< 标题数组 */
@property (nonatomic, strong) UITableView *menuTableView;     /**< 菜单表 */
@property (nonatomic, strong) itemActionBlock itemAction;     /**< 点击cell回调 */

@end

@implementation JWMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0];
        [self addSubview:self.bgImageView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

+ (id)menuView
{
    JWMenuView *menuView = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    return menuView;
}

- (void)imageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray itemAction:(itemActionBlock)itemAction
{
    self.imageArray = imageArray;
    self.titleArray = titleArray;
    self.itemAction = itemAction;
    
    NSEnumerator *frontToBackWindows = [[UIApplication sharedApplication].windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal && !window.hidden) {
            [window addSubview:self];
            break;
        }
    }
    
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1];
        
        CGRect frame = self.bgImageView.frame;
        frame.size = CGSizeMake(145, 5*50+10);
        frame.origin.x = [UIScreen mainScreen].bounds.size.width-(145+5);
        self.bgImageView.frame = frame;
    } completion:^(BOOL finished) {
        [self.bgImageView addSubview:self.menuTableView];
    }];
}

+ (void)showWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray itemAction:(itemActionBlock)itemAction
{
    [[self menuView] imageArray:imageArray titleArray:titleArray itemAction:itemAction];
}

- (void)tapAction
{
    self.menuTableView.hidden = YES;
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0];
        
        CGRect frame = self.bgImageView.frame;
        frame.size = CGSizeMake(0, 0);
        frame.origin.x = [UIScreen mainScreen].bounds.size.width-5;
        self.bgImageView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self tapAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
    iconImageView.frame = CGRectMake(20, 10, 30, 30);
    [cell.contentView addSubview:iconImageView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 80, 50)];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.text = self.titleArray[indexPath.row];
    [cell.contentView addSubview:titleLable];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemAction) {
        self.itemAction(indexPath.row);
    }
    [self tapAction];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //分隔线左对齐
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UIImageView *)bgImageView
{
    if(_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bottombg"]];
        _bgImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-5, 64, 0, 0);
        _bgImageView.layer.cornerRadius = 5;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UITableView *)menuTableView
{
    if(_menuTableView == nil)
    {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, 145, 250) style:UITableViewStylePlain];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.showsVerticalScrollIndicator = NO;
        _menuTableView.bounces = NO;
        _menuTableView.rowHeight = 50;
        _menuTableView.layer.cornerRadius = 5;
        _menuTableView.layer.masksToBounds = YES;
    }
    return _menuTableView;
}

@end
