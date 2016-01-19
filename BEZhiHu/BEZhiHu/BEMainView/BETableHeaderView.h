//
//  BETableHeaderView.h
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEScrollAndPageView.h"

@interface BETableHeaderView : UIView<BEcrollViewViewDelegate>
{
    BEScrollAndPageView *scrollandPageView;
}

@property (nonatomic, strong) NSMutableArray *imageArray;


@end
