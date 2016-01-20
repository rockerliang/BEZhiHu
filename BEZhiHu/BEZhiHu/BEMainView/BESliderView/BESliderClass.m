//
//  BESliderClass.m
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/20.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import "BESliderClass.h"

@implementation BESliderClass
static BESliderClass *sliderClass = nil;

+ (instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sliderClass = [[BESliderClass alloc] init];
    });
    return sliderClass;
}
-(id)init {
    
    if (self = [super init]) {
        // init code
        blackView = [[UIView alloc] init];
        blackView.backgroundColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:0.6];
        
        sliderView = [[BESliderView alloc] initWithFrame:CGRectMake(-SCREENWIDTH * 2/3, 0, SCREENWIDTH *2/3, SCREENHEIGHT)];
        sliderView.dataArray = [NSMutableArray arrayWithObjects:@"tes1", @"tes2",@"tes3",@"tes5",nil];
        [sliderView loadData];
        
        UITapGestureRecognizer *tapHide = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSliderView:)];
        [blackView addGestureRecognizer:tapHide];
        
    }
    return self;
}


+ (instancetype)alloc
{
    if (sliderClass) {
        return sliderClass;
    }
    return [super alloc];
}

- (id)copy
{
    if (sliderClass) {
        return sliderClass;
    }
    return [super copy];
}

-(void)showSliderView:(UIView *)view andMoveView:(UIView *)viewM andMoveViewX:(CGFloat)originx selectCell:(selectCellBlock)block
{
    sliderView.selectblock = block;
    blackView.frame = CGRectMake(view.frame.size.width *2/3, 0, view.frame.size.width /3, view.frame.size.height);
    [view addSubview:sliderView];
    
    [UIView animateWithDuration:0.2f animations:^{
        sliderView.frame = CGRectMake(0, 0, view.frame.size.width *2/3, SCREENHEIGHT);
        viewM.frame = CGRectMake(((view.frame.size.width * 2) / 3) + originx , viewM.frame.origin.y, viewM.frame.size.width, viewM.frame.size.height);
    } completion:^(BOOL finished) {
        [view addSubview:blackView];
    }];
}

-(void)hideSliserView:(UIView *)view andMoveView:(UIView *)viewM andMoveViewOriginX:(CGFloat)originx
{
    NSLog(@"1");
    [blackView removeFromSuperview];
    [UIView animateWithDuration:0.2f animations:^{
        sliderView.frame = CGRectMake(-SCREENWIDTH * 2/3, 0, SCREENWIDTH *2/3, SCREENHEIGHT);
        viewM.frame = CGRectMake(originx, viewM.frame.origin.y, viewM.frame.size.width, viewM.frame.size.height);
    } completion:^(BOOL finished) {
        NSLog(@"2");
        [sliderView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
}

-(void)hideSliderView:(UITapGestureRecognizer *)tap
{
    UIView *view1 = (UIView *)[tap view];
    UIView *view2 = view1.superview;
    [blackView removeFromSuperview];
    [UIView animateWithDuration:0.2f animations:^{
        sliderView.frame = CGRectMake(-SCREENWIDTH * 2/3, 0, SCREENWIDTH *2/3, SCREENHEIGHT);
        for(UIView *sub in [view2 subviews])
        {
            if([sub isKindOfClass:[UIView class]])
            {
                sub.frame = CGRectMake(sub.frame.origin.x - (SCREENWIDTH * 2/3), sub.frame.origin.y, sub.frame.size.width, sub.frame.size.height);
            }
        }
    } completion:^(BOOL finished) {
        [sliderView removeFromSuperview];
    }];
}


-(void)showSliderViewByScrollX:(CGFloat)x inView:(UIView *)view andMoveView:(UIView *)viewM andMoveViewOriginX:(CGFloat)originx
{
    blackView.frame = CGRectMake(view.frame.size.width *2/3, 0, view.frame.size.width /3, view.frame.size.height);
    
    [view addSubview:sliderView];
    if(x < SCREENWIDTH * 2 / 3)
    {
        [blackView removeFromSuperview];
        [UIView animateWithDuration:0.1f animations:^{
            sliderView.frame = CGRectMake(-SCREENWIDTH * 2/3 + x, 0, SCREENWIDTH *2/3, SCREENHEIGHT);
            viewM.frame = CGRectMake(originx + x, viewM.frame.origin.y, viewM.frame.size.width, viewM.frame.size.height);
        } completion:^(BOOL finished) {
        }];
    }
    if(x >= SCREENWIDTH * 2 / 3)
    {
        [UIView animateWithDuration:0.1f animations:^{
            sliderView.frame = CGRectMake(0, 0, SCREENWIDTH *2/3, SCREENHEIGHT);
            viewM.frame = CGRectMake(((view.frame.size.width * 2) / 3) + originx , viewM.frame.origin.y, viewM.frame.size.width, viewM.frame.size.height);
        } completion:^(BOOL finished) {
            [view addSubview:blackView];
        }];
    }
}




@end
