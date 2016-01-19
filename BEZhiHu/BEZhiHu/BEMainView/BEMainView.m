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
        self.topItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        self.topItemView.backgroundColor = [UIColor blueColor];
        self.topItemView.alpha = 0.0f;
        [self addSubview:self.topItemView];
        
        self.dataArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"1",@"2",@"3", nil];
        
        self.headerView = [[BETableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height - 64) / 2)];
       // self.headerView.backgroundColor = [UIColor redColor];
        self.tableViewBE = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64)];
        self.tableViewBE.delegate = self;
        self.tableViewBE.dataSource = self;
        self.tableViewBE.tableHeaderView = self.headerView;
        [self addSubview:self.tableViewBE];
    }
    return self;
}

#pragma -mark UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

@end
