//
//  ViewController.h
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMainView.h"
#import "BEDetailViewController.h"

@interface ViewController : UIViewController
{
    CGPoint originP;
    CGFloat move;
    
    CGFloat originX;
    BEMainView *mainView;
}

@property (nonatomic, strong) UIButton *itemBtn;


@end

