//
//  BESliderView.h
//  BEProgressViewNew
//
//  Created by ihefe26 on 15/11/11.
//  Copyright © 2015年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BESliderTableViewCell.h"

#define SCREENWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREENHEIGHT ([[UIScreen mainScreen] bounds].size.height)

typedef void(^selectCellBlock)(NSInteger index);


@interface BESliderView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableViewBE;
}
@property (strong, nonatomic) selectCellBlock selectblock;

@property (strong, nonatomic) NSMutableArray *dataArray;

-(void)loadData;

@end
