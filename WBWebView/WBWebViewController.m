//
//  WBWebViewController.m
//  WBWebView
//
//  Created by 李伟宾 on 2017/12/20.
//  Copyright © 2017年 liweibin. All rights reserved.
//

#import "WBWebViewController.h"

#define NAV_H 64
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define WBBackgroundColor   [UIColor colorWithRed:0.937 green:0.941 blue:0.945 alpha:1.000] // 视图背景色
#define WBDefaultColor  [UIColor colorWithRed:255/255.f green: 163/255.f blue:64/255.f alpha:1.000] //默认主题颜色

@interface WBWebViewController () <UIWebViewDelegate>

{
    UIView      *_navView;          //隐藏系统nav,使用自定义nav视图
    UILabel     *_navTitleLabel;    //标题
    UIButton    *_navBackBtn;       //返回按钮
    UIButton    *_navPopBtn;        //关闭按钮
    UIButton    *_collectButton;    //收藏
    UIButton    *_shareButton;      //分享
    UIWebView   *_webView;          //网页
    
    BOOL    _isHide;
}
@end

@implementation WBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //nav
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,NAV_H)];
    _navView.backgroundColor = WBDefaultColor;
    _navView.userInteractionEnabled = YES;
    [self.view addSubview:_navView];
    
    //标题
    _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, SCREEN_WIDTH-240, 44)];
    _navTitleLabel.textColor = [UIColor whiteColor];
    _navTitleLabel.font = [UIFont systemFontOfSize:18];
    _navTitleLabel.numberOfLines = 0;
    _navTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:_navTitleLabel];
    
    //返回按钮
    _navBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    _navBackBtn.backgroundColor = [UIColor redColor];
    [_navBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_navBackBtn addTarget:self action:@selector(navBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_navBackBtn];
    
    //关闭按钮
    _navPopBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 20, 60, 44)];
    _navPopBtn.backgroundColor = [UIColor blueColor];
    [_navPopBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_navPopBtn addTarget:self action:@selector(navPopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_navPopBtn];
    
    //收藏按钮(用来测试触发首页搜索点击事件)
    _collectButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 20, 60, 44)];
    _collectButton.backgroundColor = [UIColor greenColor];
    [_collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [_collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_collectButton];
    
    //分享按钮(用来测试隐藏/显示div)
    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 20, 60, 44)];
    _shareButton.backgroundColor = [UIColor purpleColor];
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_shareButton];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAV_H, SCREEN_WIDTH, SCREEN_HEIGHT- NAV_H)];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://study.beisu100.com/English_word/grade_list.html"]]];
    [self.view addSubview:_webView];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //获取网页标题
    _navTitleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
//返回
- (void)navBackBtnClick {
    //判断是否有上一层H5页面
    if ([_webView canGoBack]) {
        //如果有则返回
        [_webView goBack];
    } else {
        [self navPopBtnClick];
    }
}

//关闭
- (void)navPopBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//分享(测试隐藏/显示div)
- (void)shareButtonClick {
    _isHide = !_isHide;
    
    if (_isHide) {
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('nav_bg').style.display = 'none'"];
    } else {
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('nav_bg').style.display = 'block'"];
    }
    
    //logo
}

//收藏(测试执行js点击事件)
- (void)collectButtonClick {
    [_webView stringByEvaluatingJavaScriptFromString:@"searchButtonClick();"];
}

@end
