//
//  BEDetailViewController.m
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BEDetailViewController.h"

@interface BEDetailViewController ()

@end

@implementation BEDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollViewBE = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollViewBE.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + (self.view.frame.size.height - 64) / 2);
    [self.view addSubview:self.scrollViewBE];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //让右滑手势有效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
}

#pragma -mark 初始化imageView 和 webView
-(void)initImageViewBEAndWebViewBEByID:(NSString *)noteID
{
    self.imageViewBE = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height - 64) / 2)];
    self.webViewBE = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 32, self.view.frame.size.width, self.view.frame.size.height / 2 + 32)];
    NSString *url = [NSString stringWithFormat:@"%@%@",GetBigImageByIdURL,noteID];
    [BEAFNetworking get:url params:nil success:^(id responseObj) {
        NSURL *urlImage = [NSURL URLWithString:responseObj[@"image"]];
        [self.imageViewBE setImageWithURL:urlImage];
        [self.scrollViewBE addSubview:self.imageViewBE];
        self.webViewBE.scalesPageToFit = YES;
        [self.webViewBE loadHTMLString:responseObj[@"body"] baseURL:nil];
        [self.scrollViewBE addSubview:self.webViewBE];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
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
