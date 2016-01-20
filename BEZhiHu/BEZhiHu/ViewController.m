//
//  ViewController.m
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 23, 23)];
    [self.itemBtn setImage:[UIImage imageNamed:@"item"] forState:UIControlStateNormal];
    [self.itemBtn addTarget:self action:@selector(showSlider) forControlEvents:UIControlEventTouchUpInside];
    
    mainView = [[BEMainView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height)];
    [mainView addSubview:self.itemBtn];
    [self.view addSubview:mainView];
    
    originX = mainView.frame.origin.x;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:pan];

    
    
}

//注册通知
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailController:) name:@"pushToDetailController" object:nil];
}

//移除通知
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushToDetailController" object:nil];
}


//跳转到详情页面
-(void)pushToDetailController:(NSNotification *)cence
{
    BEScrollPageSubject *subject = cence.object;
    BEDetailViewController *detailViewController = [[BEDetailViewController alloc] init];
    [detailViewController initImageViewBEAndWebViewBEByID:subject.noteID];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma -mark statusbar字体改成白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma -mark 添加左部菜单栏
-(void)showSlider
{
    [[BESliderClass getInstance] showSliderView:self.view andMoveView:mainView andMoveViewX:originX selectCell:^(NSInteger index) {
        if(index == 0)
        {
            
        }
        if(index == 1)
        {
            
        }
    }];
}


-(void)panView:(UIPanGestureRecognizer *)pan
{
    if(pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint origin2 = [pan translationInView:pan.view];
        move = origin2.x;
        NSLog(@"%lf",origin2.y);
        if(move > 0)
        {
            [[BESliderClass getInstance] showSliderViewByScrollX:move inView:self.view andMoveView:mainView andMoveViewOriginX:originX] ;
        }
    }
    if(pan.state == UIGestureRecognizerStateEnded)
    {
        if(move < 150)
        {
            [[BESliderClass getInstance] hideSliserView:self.view andMoveView:mainView andMoveViewOriginX:originX];
        }
        if(move >= 150)
        {
            [[BESliderClass getInstance] showSliderView:self.view andMoveView:mainView andMoveViewX:originX selectCell:^(NSInteger index) {
                if(index == 1)
                {
                    NSLog(@"hello %ld",index);
                }
                if(index == 2)
                {
                    NSLog(@"hello %ld",index);
                }
                if(index == 3)
                {
                    NSLog(@"hello %ld",index);
                }
                if(index == 4)
                {
                    NSLog(@"hello %ld",index);
                }
                
            }];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
