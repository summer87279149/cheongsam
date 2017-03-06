//
//  WebViewController.m
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "WebViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface WebViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, getter=didFailLoading) BOOL failedLoading;
@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}
- (instancetype)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
   
    [self setupProgress];
    
    [self setupEmptyDelegate];
 
}

-(void)setupWebView{
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

-(void)setupProgress{
    _progressView = [[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 2)];
    _progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;

}

-(void)setupEmptyDelegate{
    self.webView.scrollView.emptyDataSetSource = self;
    self.webView.scrollView.emptyDataSetDelegate = self;

}


#pragma mark - NJKWebViewProgressDelegate methods
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:NO];
}


#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.failedLoading = NO;
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.failedLoading = YES;
    
    [self.webView.scrollView reloadEmptyDataSet];
}


#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.webView.isLoading || !self.didFailLoading) {
        return nil;
    }
    
    NSString *text = @"Safari cannot open the page because your iPhone is not connected to the Internet.";
    UIColor *textColor = [UIColor colorWithRed:125/255.0 green:127/255.0 blue:127/255.0 alpha:1.0];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 2.0;
    
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
