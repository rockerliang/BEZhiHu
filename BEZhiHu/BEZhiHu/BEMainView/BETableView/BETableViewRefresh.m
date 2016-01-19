//
//  BETableViewRefresh.m
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BETableViewRefresh.h"

@implementation BETableViewRefresh

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        loadNum = 0;
        self.refreshHeadView = [[BERefreshHeaderView alloc] initWithFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        
        self.tableViewBE = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.tableViewBE.delegate = self;
        self.tableViewBE.dataSource  = self;
        [self addSubview:self.tableViewBE];
        [self.tableViewBE addSubview:self.refreshHeadView];

    }
    return self;
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableViewBE reloadData];
}

#pragma -mark 获取时间，返回NSString
-(NSString *)getDateByMoreDate:(NSInteger)moreNum
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)*moreNum];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyMMdd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

#pragma -mark UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"BETableViewCell";
    BETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BETableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BEScrollPageSubject *subject = self.dataArray[indexPath.row];
    cell.titleLabel.text = subject.title;
    NSURL *imageUrl = [NSURL URLWithString:subject.imageUrl];
    [cell.titleImageView setImageWithURL:imageUrl];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BEScrollPageSubject *subject = self.dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToDetailController" object:subject];
}
#pragma -mark UIScorollerViewDeleagte

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentSet = scrollView.contentOffset;
    if([self.delegate respondsToSelector:@selector(moveContentOffSet:)])
    {
        [self.delegate moveContentOffSet:contentSet.y];
    }
    
    
    if(contentSet.y > -70)
    {
        if(scrollView.dragging)
        {
            self.refreshHeadView.freshLabel.text = @"下拉刷新...";
            self.refreshHeadView.freshImgView.animationImages = nil;
            //更换下拉刷新的图片
            self.refreshHeadView.freshImgView.image = [UIImage imageNamed:@"1.jpg"];
        }
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.refreshHeadView.freshDataLabel.text = [dateFormatter stringFromDate:nowDate];
    }
    
    if(contentSet.y < -70)
    {
        if(scrollView.dragging)
        {
            self.refreshHeadView.freshLabel.text = @"松开刷新...";
            self.refreshHeadView.freshImgView.animationImages = nil;
            //更换松开刷新的图片
            self.refreshHeadView.freshImgView.image = [UIImage imageNamed:@"2.jpg"];
        }
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.refreshHeadView.freshDataLabel.text = [dateFormatter stringFromDate:nowDate];
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //下拉刷新
    if(scrollView.contentOffset.y <= -70)
    {
        self.refreshHeadView.freshLabel.text = @"正在刷新...";
        //更换加载中的动画图片
        self.refreshHeadView.freshImgView.animationImages = [NSArray arrayWithObjects:
                                                             [UIImage imageNamed:@"1.jpg"],
                                                             [UIImage imageNamed:@"2.jpg"],
                                                             [UIImage imageNamed:@"3.jpg"],
                                                             [UIImage imageNamed:@"4.jpg"], nil];
        [self.refreshHeadView setimgViewAnimation];
        [UIView animateWithDuration:0.1f animations:^{
            self.tableViewBE.contentInset = UIEdgeInsetsMake(70.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished) {
            NSDate *nowDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.refreshHeadView.freshDataLabel.text = [dateFormatter stringFromDate:nowDate];
            [self performSelector:@selector(loadRefreshDataBE) withObject:nil afterDelay:0.1f];
        }];
    }
    
    //上拉加载更多
    if(scrollView.contentOffset.y > self.tableViewBE.contentSize.height - self.tableViewBE.frame.size.height)
    {
        self.loadMoreView = [[BELoadMoreView alloc] initWithFrame:CGRectMake(0, self.tableViewBE.contentSize.height, self.frame.size.width, 60)];
        [self.tableViewBE addSubview:self.loadMoreView];
        //更换上拉下载的动画图片
        self.loadMoreView.moreImgView.animationImages = [NSArray arrayWithObjects:
                                                        [UIImage imageNamed:@"1.jpg"],
                                                        [UIImage imageNamed:@"2.jpg"],
                                                        [UIImage imageNamed:@"3.jpg"],
                                                        [UIImage imageNamed:@"4.jpg"], nil];
        [self.loadMoreView setimgViewAnimation];
        [UIView animateWithDuration:0.1f animations:^{
            self.tableViewBE.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
        } completion:^(BOOL finished) {
            [self performSelector:@selector(loadMoreDataBE) withObject:nil afterDelay:0.1f];
        }];
    }

}

-(void)loadRefreshDataBE
{
    if ([self.delegate respondsToSelector:@selector(loadRefreshData)]) {
        [self.delegate loadRefreshData];
    }
    [UIView animateWithDuration:0.1f animations:^{
        self.tableViewBE.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }];

    return;
}


-(void)loadMoreDataBE
{
    loadNum++;
    if([self.delegate respondsToSelector:@selector(loadMoreData:)])
    {
        [self.delegate loadMoreData:[self getDateByMoreDate:loadNum]];
    }
    [UIView animateWithDuration:0.1f animations:^{
        self.tableViewBE.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }];
    [self.loadMoreView removeFromSuperview];
    self.loadMoreView = nil;

    return;
    
}


@end
