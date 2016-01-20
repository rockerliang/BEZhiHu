//
//  BESliderClass.h
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/20.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BESliderView.h"

@interface BESliderClass : NSObject
{
    UIView *blackView;
    BESliderView *sliderView;
}

+ (instancetype)getInstance;

//点击完全弹出sliderView
-(void)showSliderView:(UIView *)view andMoveView:(UIView *)viewM andMoveViewX:(CGFloat)originx selectCell:(selectCellBlock)block;

//隐藏sliderView
-(void)hideSliserView:(UIView *)view andMoveView:(UIView *)viewM andMoveViewOriginX:(CGFloat)originx;

//根据滑动距离出现sliderView
-(void)showSliderViewByScrollX:(CGFloat)x inView:(UIView *)view andMoveView:(UIView *)viewM andMoveViewOriginX:(CGFloat)originx;



@end
