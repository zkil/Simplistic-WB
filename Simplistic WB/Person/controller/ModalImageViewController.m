//
//  ModalImageViewController.m
//  Simplistic WB
//
//  Created by LXF on 15/12/7.
//  Copyright (c) 2015年 wzk. All rights reserved.
//

#import "ModalImageViewController.h"
#import "UIImage+Circle.h"
@interface ModalImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UIImageView *backgroundimage;
}

@end

@implementation ModalImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置imageview
    backgroundimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    backgroundimage.image = self.image;
    [self.view addSubview:backgroundimage];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *changebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    changebtn.frame = CGRectMake(50, 400, [UIScreen mainScreen].bounds.size.width-100, 40);
    changebtn.backgroundColor = [UIColor lightGrayColor];
    changebtn.tintColor = [UIColor blackColor];
    [changebtn setTitle:@"更改图片" forState:UIControlStateNormal];
    [changebtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changebtn];
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    savebtn.frame = CGRectMake(50, 500, [UIScreen mainScreen].bounds.size.width-100, 40);
    savebtn.backgroundColor = [UIColor lightGrayColor];
    savebtn.tintColor = [UIColor blackColor];
    [savebtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [savebtn addTarget:self action:@selector(btnAtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    
}

//按钮触发方法
-(void)btnAtion:(UIButton*)sender
{
   // NSLog(@"按钮点击");
}

//退出模态
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIImage *image = [UIImage OriginImage:backgroundimage.image scaleToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 200)];
    [self.changeBackgroundImageDelegate ChangeBackgroundImage:image];
    NSUserDefaults *userdefaults = [NSUserDefaults  standardUserDefaults];
    NSData *data = UIImageJPEGRepresentation(backgroundimage.image, 1.0);
    [userdefaults setObject:data forKey:@"imagedata"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//更改按钮触发方法
-(void)backAction
{
    UIImagePickerController*photo=[[UIImagePickerController alloc]init];
    photo.delegate=self;
    [photo setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [photo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [photo setAllowsEditing:YES];
    [self presentViewController:photo animated:YES completion:nil];
}

//成功获得相片还是视频后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取图片裁剪的图
    UIImage* edit = [info objectForKey:UIImagePickerControllerOriginalImage];
    backgroundimage.image = edit;
    //模态方式退出uiimagepickercontroller
    [picker dismissViewControllerAnimated:YES completion:nil];
}




@end
