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
        self.scrollandPageView = [[BEScrollAndPageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        self.imageViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 80, self.frame.size.width - 20, 60)];
        self.imageViewLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.imageViewLabel.numberOfLines = 0;
        self.imageViewLabel.font = [UIFont systemFontOfSize:20.f];
        self.imageViewLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

#pragma -mark 解析传过来的model数组
-(void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    NSMutableArray *imgViewArray = [NSMutableArray array];
    for (int i=0; i < 6; i++) {
        BEScrollPageSubject *subject = imageArray[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        NSURL *imageUrl = [NSURL URLWithString:subject.imageUrl];
        [imageView setImageWithURL:imageUrl];
        [imgViewArray addObject:imageView];
    }
    //把imageView数组存到whView里
    [self.scrollandPageView setImageViewAry:imgViewArray];
    
    //把图片展示的view加到当前页面
    [self addSubview:self.scrollandPageView];
    
    BEScrollPageSubject *sub = imageArray[0];
    self.imageViewLabel.text = sub.title;
    [self.scrollandPageView addSubview:self.imageViewLabel];
    
    //开启自动翻页
    [self.scrollandPageView shouldAutoShow:YES];
    
    //遵守协议
    self.scrollandPageView.delegate = self;
}




#pragma mark 协议里面方法，点击某一页
-(void)didClickPage:(BEScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld页",(long)index);
    BEScrollPageSubject *subject = self.imageArray[index - 1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToDetailController" object:subject];
}

#pragma mark scrollerView跳转到下一页，主要改变图片上新闻标题
-(void)scrollNextImgView:(NSInteger)pageNum
{
    BEScrollPageSubject *subject = self.imageArray[pageNum];
    self.imageViewLabel.text = subject.title;
}




@end
