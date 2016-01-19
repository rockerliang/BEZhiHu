//
//  BETableViewRefresh.h
//  BETableViewRefresh
//
//  Created by ihefe26 on 16/1/11.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BERefreshHeaderView.h"
#import "BELoadMoreView.h"
#import "BETableViewCell.h"
#import "BEScrollPageSubject.h"

@protocol BETableViewRefreshDelegate <NSObject>

//下拉更新数据代理方法
-(void)loadRefreshData;

//上拉加载更多代理方法
-(void)loadMoreData:(NSString *)date;

//上拉的时候传个contentOffset来计算透明度
-(void)moveContentOffSet:(CGFloat)yMove;

@end

@interface BETableViewRefresh : UIView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger loadNum;
}

@property (nonatomic, assign) id<BETableViewRefreshDelegate>delegate;

@property (nonatomic, strong) UITableView *tableViewBE;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) BERefreshHeaderView *refreshHeadView;

@property (nonatomic, strong) BELoadMoreView *loadMoreView;

@end
