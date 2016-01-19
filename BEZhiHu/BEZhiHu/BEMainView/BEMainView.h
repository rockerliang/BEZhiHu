//
//  BEMainView.h
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BETableHeaderView.h"

@interface BEMainView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *topItemView;

@property (nonatomic, strong) BETableHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableViewBE;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
