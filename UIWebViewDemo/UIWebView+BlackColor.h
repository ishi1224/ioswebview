//
//  UIWebView+BlackColor.h
//  shop
//
//  Created by zhangwenqiang on 16/6/6.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (BlackColor)<UIAlertViewDelegate>

- (void)clearBackColorForWebView;//清楚上下黑边

- (void)didNotLeftOrRightScrollForWebView;//禁止左右滑动

@end
