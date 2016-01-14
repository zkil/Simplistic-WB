//
//  OriginalImageController.m
//  Simplistic WB
//
//  Created by wzk on 15/12/3.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "OriginalImageController.h"
#import "HttpTool.h"
@interface OriginalImageController ()
{
    UIActivityIndicatorView *_activityIndicator;
}
@end

@implementation OriginalImageController
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
-(void)setPic_url:(NSString *)pic_url
{
    _pic_url = pic_url;
    
}
#pragma -mark- 获得大图的url
-(NSString *)getOriginal_pic_URL:(NSString *)pic_url
{
    return [pic_url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //显示图片的view
    _orinalImgeView = [[UIImageView alloc]initWithFrame:self.view.frame];
    _orinalImgeView.contentMode = UIViewContentModeScaleAspectFit;
    _orinalImgeView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_orinalImgeView];
    //加入活动指示器
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    _activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
    
    [HttpTool HttpToolDowmloadImageWithURL:self.pic_url success:^(id object) {
        self.orinalImgeView.image = object;
    } failure:^(NSError *error) {
        
    }];
    [HttpTool HttpToolDowmloadImageWithURL:[self getOriginal_pic_URL:self.pic_url] success:^(id object) {
        self.orinalImgeView.image = object;
        [_activityIndicator stopAnimating];
    } failure:^(NSError *error) {
        
    }];
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
