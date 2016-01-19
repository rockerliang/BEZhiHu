//
//  BEMainView.h
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BETableHeaderView.h"
#import "BEScrollPageSubject.h"
#import "BETableViewRefresh.h"

@interface BEMainView : UIView<BETableViewRefreshDelegate>

@property (nonatomic, strong) UIView *topItemView;

@property (nonatomic, strong) BETableHeaderView *headerView;

@property (nonatomic, strong) BETableViewRefresh *tableViewBE;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
