//
//  UITabBar+badge.m
//  FaceTalk
//
//  Created by kevin on 15/7/2.
//  Copyright (c) 2015年 iEver. All rights reserved.
//

#import "UITabBar+badge.h"
#import "CustomBadge.h"

#define TabbarItemNums 5.0    //tabbar的数量

@interface UITabBar ()
{
    CustomBadge *badgeNumberView;
}
@end

@implementation UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    [self addSubview:badgeView];
    
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

#pragma mark - show number
- (void)showBadgeOnItemIndex:(int)index badgeNumber:(NSInteger)number
{
    CustomBadge *badgeView = (CustomBadge *)[self viewWithTag:888+index];
    if (!badgeView)
    {
        BadgeStyle *badgeStyle = [BadgeStyle freeStyleWithTextColor:[UIColor whiteColor]
                                                      withInsetColor:[UIColor redColor]
                                                      withFrameColor:nil
                                                           withFrame:NO
                                                          withShadow:NO
                                                         withShining:NO
                                                        withFontType:BadgeStyleFontTypeHelveticaNeueLight];

        badgeView = [CustomBadge customBadgeWithString:@"0" withScale:.6f withStyle:badgeStyle];
        badgeView.tag = 888+index;

        float percentX = (index +0.5) / TabbarItemNums;
        CGFloat x = ceilf(percentX * self.frame.size.width)+3;
        CGFloat y = ceilf(0.05 * self.frame.size.height);
        badgeView.frame = CGRectMake(x, y, 8, 8);
        [self addSubview:badgeView];
    }

    if (number>0)
    {
        badgeView.hidden = NO;
        NSString *bageStr = number>99?@"99+":[NSString stringWithFormat:@"%ld",(long)number];
        [badgeView autoBadgeSizeWithString:bageStr];
    } else {
        badgeView.hidden = YES;
    }
}

@end
