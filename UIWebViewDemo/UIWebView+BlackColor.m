//
//  UIWebView+BlackColor.m
//  shop
//
//  Created by zhangwenqiang on 16/6/6.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "UIWebView+BlackColor.h"

@implementation UIWebView (BlackColor)

- (void)clearBackColorForWebView{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            //            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO];
            for (UIView *shadowView in aView.subviews) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;//上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                }
            }
        }
    }
}

- (void)didNotLeftOrRightScrollForWebView{
    [(UIScrollView *)[[self subviews] objectAtIndex:0] setBounces:NO];
}

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"Alert Title" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [customAlert show];
}

static BOOL diagStat = NO;

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:@"Confirm Title" message:message delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];
    [confirmDiag show];
    
    while (confirmDiag.hidden == NO && confirmDiag.superview != nil){
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    
    return diagStat;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0){
        diagStat = NO;
        
    }else if (buttonIndex == 1){
        diagStat = YES;
    }
}


@end
