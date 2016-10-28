//
//  UITabBar+badge.h
//  FaceTalk
//
//  Created by kevin on 15/7/2.
//  Copyright (c) 2015年 iEver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
/**
 *  在tabbar上展示气泡
 *
 *  @param index  tabbar选项索引
 *  @param number 气泡展示数字，当该值为0时自动隐藏
 */
- (void)showBadgeOnItemIndex:(int)index badgeNumber:(NSUInteger)number;

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
