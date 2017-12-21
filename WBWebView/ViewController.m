//
//  ViewController.m
//  WBWebView
//
//  Created by 李伟宾 on 2017/12/20.
//  Copyright © 2017年 liweibin. All rights reserved.
//

#import "ViewController.h"
#import "WBWebViewController.h"

@interface ViewController () <UIWebViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)click:(UIButton *)sender {
    WBWebViewController *web = [[WBWebViewController alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}

@end
