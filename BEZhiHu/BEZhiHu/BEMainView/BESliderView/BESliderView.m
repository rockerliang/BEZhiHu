//
//  BESliderView.m
//  BEProgressViewNew
//
//  Created by ihefe26 on 15/11/11.
//  Copyright © 2015年 zhangliang. All rights reserved.
//

#import "BESliderView.h"

static NSString *cellID = @"IHFBEApoointRecordCell";

@implementation BESliderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
        NSLog(@"%f%f",SCREENWIDTH,SCREENHEIGHT);
        tableViewBE = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH / 3 *2, SCREENHEIGHT - 100)];
        tableViewBE.backgroundColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
        tableViewBE.delegate = self;
        tableViewBE.dataSource = self;
        tableViewBE.userInteractionEnabled = YES;
       tableViewBE.separatorColor = [UIColor grayColor];
        [self addSubview:tableViewBE];
        
        UINib *cellNIB = [UINib nibWithNibName:@"BESliderTableViewCell" bundle:[NSBundle mainBundle]];
        [tableViewBE registerNib:cellNIB forCellReuseIdentifier:cellID];
        
    
    }
    return self;
}

-(void)loadData
{
    [tableViewBE reloadData];
}

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
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    cell.backgroundColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    self.selectblock(indexPath.row);
}

@end
