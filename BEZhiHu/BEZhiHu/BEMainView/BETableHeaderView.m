//
//  BETableHeaderView.m
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BETableHeaderView.h"

@implementation BETableHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        scrollandPageView = [[BEScrollAndPageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
    }
    return self;
}

-(void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    for (int i=1; i<6; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d",i]];
        [_imageArray addObject:imageView];
    }
    //把imageView数组存到whView里
    [scrollandPageView setImageViewAry:_imageArray];
    
    //把图片展示的view加到当前页面
    [self addSubview:scrollandPageView];
    
    //开启自动翻页
    [scrollandPageView shouldAutoShow:YES];
    
    //遵守协议
    scrollandPageView.delegate = self;
}


#pragma mark 协议里面方法，点击某一页
-(void)didClickPage:(BEScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld页",(long)index);
}


//#pragma mark 界面消失的时候，停止自动滚动
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [_whView shouldAutoShow:NO];
//}


@end
