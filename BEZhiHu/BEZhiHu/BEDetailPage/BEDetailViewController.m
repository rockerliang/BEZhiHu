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
    self.imageViewBE = [[UIImageView alloc] initWithFrame:CGRectMake(0, -40 , self.view.frame.size.width, (self.view.frame.size.height - 64) / 2)];
    self.webViewBE = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.webViewBE.scrollView setScrollEnabled:YES];

    UIEdgeInsets contentInset= UIEdgeInsetsMake(0,.0f,.0f,.0f);
    [self.webViewBE.scrollView setContentInset:contentInset];
    //在scrollView中设置空隙给headView
    [self.webViewBE.scrollView setContentOffset:CGPointMake(0, 0)];
    [self.webViewBE.scrollView addSubview:self.imageViewBE];
    NSString *url = [NSString stringWithFormat:@"%@%@",GetBigImageByIdURL,noteID];
    
    [BEAFNetworking get:url params:nil success:^(id responseObj) {
        NSURL *urlImage = [NSURL URLWithString:responseObj[@"image"]];
        [self.imageViewBE setImageWithURL:urlImage];
        //self.webViewBE.scalesPageToFit = YES;
        [self.webViewBE loadHTMLString:[self handleHTMLString:responseObj] baseURL:nil];
        NSLog(@"%@", responseObj[@"body"]);
//        self.webViewBE.scalesPageToFit = YES;
        [self.view addSubview:self.webViewBE];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}


- (NSString *)handleHTMLString:(NSDictionary *)htmlString
{
    NSMutableString *toReturn = [NSMutableString string];
    
    [toReturn appendString:@"<!DOCTYPE html><html><head><title></title><link rel=\"stylesheet\" type=\"text/css\" href=\"http://news-at.zhihu.com/css/news_qa.auto.css?v=77778\"></head><body>"];
    [toReturn appendString:htmlString[@"body"]];
    [toReturn appendString:@"</body></html>"];
    
    return toReturn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark statusbar字体改成白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
