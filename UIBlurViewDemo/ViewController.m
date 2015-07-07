//
//  ViewController.m
//  UIBlurViewDemo
//
//  Created by taowang on 15/7/7.
//  Copyright (c) 2015年 Plague. All rights reserved.
//

#import "ViewController.h"
#import "UIBlurView.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UIBlurView *_blurView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)loadView
{
    self.view = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = [[UIScreen mainScreen]bounds];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:backImageView];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    backImageView.image = [UIImage imageNamed:@"IMG_0652.jpg"];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [testButton addTarget:self action:@selector(showBlur) forControlEvents:UIControlEventTouchUpInside];
    testButton.center = self.view.center;
    [self.view addSubview:testButton];
    //init blurView
    [self setupBlurView];
}
-(void)showBlur
{
    [self showInView:self.view];
}
-(void)setupBlurView
{
    _blurView = [[UIBlurView alloc]init];
    _blurView.userInteractionEnabled = YES;
    _blurView.alpha = 0.0f;
    _blurView.frame = self.view.frame;
    [self.view addSubview:_blurView];
}
//show blurView
-(void)showInView:(UIView *)view
{
    
    UITapGestureRecognizer* tapCloseBlurGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [_blurView addGestureRecognizer:tapCloseBlurGesture];
    
    [_blurView attachView: view];//set source view
    [_blurView setNeedsBlur];//show screenshot and blurview
    _blurView.alpha = 0.0f;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _blurView.alpha = 1.f;
    } completion:^(BOOL finished) {
    }];
    
}
//hide blurView
-(void)hide
{
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _blurView.alpha = 0.0f;
    } completion:^(BOOL finished) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
