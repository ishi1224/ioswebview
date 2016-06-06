//
//  ViewController.m
//  UIWebViewDemo
//
//  Created by zhangwenqiang on 16/6/6.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"
#import "UIWebView+BlackColor.h"

@interface ViewController ()<UIWebViewDelegate>

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGRect mainFrame;
@property(nonatomic, assign) CGRect statusFrame;
@property(nonatomic,strong) UIWebView* webView;
@property(nonatomic, strong) WebViewJavascriptBridge* bridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // [WebViewJavascriptBridge enableLogging];
    
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    NSString*path =[[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSString*htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];//(1)
    
    
    //NSURL*url=[NSURL fileURLWithPath:path];//创建URL
    NSURL* url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest*request=[NSURLRequest requestWithURL:url];//创建NSURLRequest
    //[self.webView loadRequest:request];//加载(2)
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //register 登记呼入的数据
    [self.bridge registerHandler:@"Objective-C" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        //responseCallback(data);//回调数据的block方法
    }];
    
    //call 呼出发送数据
    [self.bridge callHandler:@"JavaScript" data:@{@"传入js":@"数据"} responseCallback:^(id responseData) {
        //responseData 回调的对象类型 id
        //这里js回调后执行的方法:{在js中执行responseCallback(data)函数进行回调}
         NSLog(@"ObjC received response: %@", responseData);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIWebView *)webView{
    if (_webView == nil) {
        CGRect frame = CGRectMake(0, self.statusFrame.size.height, self.width, self.height-self.statusFrame.size.height);
        _webView = [[UIWebView alloc] initWithFrame:frame];
        //_webview.dataDetectorTypes=UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
        [_webView.scrollView setShowsVerticalScrollIndicator:NO];//隐藏垂直滚动条
        [_webView didNotLeftOrRightScrollForWebView];
        [_webView clearBackColorForWebView];
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

-(WebViewJavascriptBridge *)bridge{
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

-(CGFloat)width{
    if (_width == 0) {
        _width = self.mainFrame.size.width;
    }
    return _width;
}

-(CGFloat)height{
    if (_height == 0) {
        _height = self.mainFrame.size.height;
    }
    return _height;
}

-(CGRect)mainFrame{
    return [[UIScreen mainScreen] bounds];
}

-(CGRect)statusFrame{
    return [[UIApplication sharedApplication] statusBarFrame];
}

@end
