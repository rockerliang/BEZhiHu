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
    BEMainView *mainView = [[BEMainView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mainView];
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
