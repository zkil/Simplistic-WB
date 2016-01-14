//
//  LoginScreenController.m
//  Simplistic WB
//
//  Created by Ibokan1 on 11/25/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "LoginScreenController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "HttpTool.h"
#import "SaveCount.h"
#import "SaveCountTool.h"
#import "MainController.h"
@interface LoginScreenController ()<UIWebViewDelegate>
{

    UIWebView *_webView; 
    
}
@end

@implementation LoginScreenController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initWithWeb];
   
    [self loadWebPage];
    
    
}

#pragma -mark- 初始化webView
-(void)initWithWeb
{
 
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    self.view = _webView;
    
    _webView.delegate = self;
    
}
#pragma -mark- web请求授权
-(void)loadWebPage
{

    NSString *urlString = [NSString stringWithFormat:@"%@oauth2/authorize?client_id=%@&redirect_uri=%@&display=mobile",BaseUrl, AppKey, RedirectUri];
    
    //请求授权的URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    //请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [_webView loadRequest:request];
    
}

#pragma -mark- 代理方法获取Access Token
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    // 获取整条路径转换成字符串
    NSString *url = request.URL.absoluteString;
    
    //查找含code=的位置
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length)
    {
        NSInteger index = range.location + range.length;
        
        //获取此时url中的code数据
        NSString *requestToken = [url substringFromIndex:index];
        
        //获取授权过的Access Token
        [self getAccessToken:requestToken];
        
        return NO;
    }
    return YES;
}

#pragma -mark- 获取Access Token
-(void)getAccessToken:(NSString *)requestToken
{
    
    NSDictionary *mdic =
  @{
    @"client_id" : AppKey,
    @"client_secret" : AppSecret,
    @"code" : requestToken,
    @"grant_type" : @"authorization_code",
    @"redirect_uri" : RedirectUri
    };
   
    // HttpTool类中自定义方法获取网页数据
    [HttpTool HttpToolPostWithBaseURL:BaseUrl path:@"oauth2/access_token" params:
     mdic success:^(id JSON)//请求成功
    {
      
        
        //获取json字典
        SaveCount *saveCount = [[SaveCount alloc]initByDictionary:JSON];
        
        //初始化单例对象
        SaveCountTool *saveCountTool = [SaveCountTool getInstance];
        
        //保存写入临时文件tmp
        [saveCountTool saveWithsaveCount:saveCount];
        
        //清除加载提示
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (saveCount)
        {
            
            MainController *ss = [MainController new];
            
            [self presentViewController:ss animated:YES completion:nil];
            
        }
        
           
    // 获取信息失败
    }failure:^(NSError *error)
    {
           
           NSLog(@"请求失败:%@", [error localizedDescription]);
           
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           
    } method:@"POST"];
    
}


#pragma -mark- web开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{

    //引入第三方类库MBProgressHUD
    MBProgressHUD *progressid = [MBProgressHUD showHUDAddedTo:webView animated:YES];
    
    //设置提示文本
    progressid.labelText = @"努力加载中";
    
    //设置字体大小
    progressid.labelFont = [UIFont systemFontOfSize:20];

    //设置字体颜色
    progressid.labelColor = [UIColor grayColor];
    
}

#pragma -mark- web结束加载
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:webView animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
