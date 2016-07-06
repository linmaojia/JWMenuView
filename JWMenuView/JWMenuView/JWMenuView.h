//
//  SCMenuView.h
//  hysc
//
//  Created by Jarvi on 16/7/5.
//  Copyright © 2016年 Jarvi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^itemActionBlock)(NSInteger row);

@interface JWMenuView : UIView
/**
 *  一句话调用菜单视图
 *
 *  @param imageArray 图片数组
 *  @param titleArray 标题数组
 *  @param itemAction item点击回调
 */
+ (void)showWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray itemAction:(itemActionBlock)itemAction;

@end
