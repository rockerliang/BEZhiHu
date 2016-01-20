//
//  BEMainView.m
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BEMainView.h"

@implementation BEMainView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.topItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 64)];
        self.topItemView.backgroundColor = [UIColor blueColor];
        self.topItemView.alpha = 0.0f;
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 40, 48, 80, 20)];
        itemLabel.text = @"今日热闻";
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.textColor = [UIColor whiteColor];
        
        self.dataArray = [NSMutableArray array];
        
        self.headerView = [[BETableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height - 64) / 2)];
        self.tableViewBE = [[BETableViewRefresh alloc] initWithFrame:CGRectMake(0, -20, self.frame.size.width, self.frame.size.height + 20)];
        self.tableViewBE.delegate = self;
        self.tableViewBE.tableViewBE.tableHeaderView = self.headerView;
        [self addSubview:self.tableViewBE];
        
        [self.tableViewBE addSubview:self.topItemView];
        [self.tableViewBE addSubview:itemLabel];
        
        [self loadScrollerPageData];
    }
    return self;
}

#pragma -mark 请求数据scrollPage数据
-(void)loadScrollerPageData
{
    [BEAFNetworking get:ScrollerAndPageURL params:nil success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        NSString *dateString = responseObj[@"date"];
        NSMutableArray *arr = responseObj[@"stories"];
        NSMutableArray *scrollDaraArray = [NSMutableArray array];
        for(int i = 0;i < arr.count; i++)
        {
            NSDictionary *dic = arr[i];
            BEScrollPageSubject *subject = [BEScrollPageSubject new];
            subject.dateStr = dateString;
            subject.noteID = dic[@"id"];
            subject.title = dic[@"title"];
            subject.imageUrl = dic[@"images"][0];
            
            if(i < 6)
            {
                NSString *urlBigImage = [NSString stringWithFormat:@"%@%@",GetBigImageByIdURL,dic[@"id"]];
                [BEAFNetworking get:urlBigImage params:nil success:^(id responseObj) {
                    subject.imageUrl = responseObj[@"image"];
                    [scrollDaraArray addObject:subject];
                    if(scrollDaraArray.count > 5)
                    {
                        self.headerView.imageArray = scrollDaraArray;
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
            if(arr.count > 9 && i > 5)
            {
                [self.dataArray addObject:subject];
            }
            if(arr.count <= 9)
            {
                [self.dataArray addObject:subject];
            }
        }
        self.tableViewBE.dataArray = self.dataArray;
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma 刷新 加载更多
-(void)loadRefreshData
{
    [self loadScrollerPageData];
}

-(void)loadMoreData:(NSString *)date
{
    NSString *urlMore = [NSString stringWithFormat:@"%@%@",LoadMoreDataURL,date];
    [BEAFNetworking get:urlMore params:nil success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        NSString *dateString = responseObj[@"date"];
        NSMutableArray *arr = responseObj[@"stories"];
        for(NSDictionary *dic in arr)
        {
            BEScrollPageSubject *subject = [BEScrollPageSubject new];
            subject.dateStr = dateString;
            subject.noteID = dic[@"id"];
            subject.title = dic[@"title"];
            subject.imageUrl = dic[@"images"][0];
            [self.dataArray addObject:subject];
        }
        self.tableViewBE.dataArray = self.dataArray;
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}

#pragma -mark tableView的代理，计算topView透明度
-(void)moveContentOffSet:(CGFloat)yMove
{
    NSLog(@"%f",yMove);
    if(yMove >= 0)
    {
        self.topItemView.alpha = yMove / 64;
    }else
    {
    
    }
}


@end
