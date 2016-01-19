//
//  ScrollerViewDemo.h
//  BERealmDemo
//
//  Created by Rocker_Command on 15/9/26.
//  Copyright (c) 2015年 Rocker_Command. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BEcrollViewViewDelegate;

@interface BEScrollAndPageView : UIView <UIScrollViewDelegate>
{
    __unsafe_unretained id <BEcrollViewViewDelegate> _delegate;
}

@property (nonatomic, assign) id <BEcrollViewViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end

@protocol BEcrollViewViewDelegate <NSObject>

@optional
- (void)didClickPage:(BEScrollAndPageView *)view atIndex:(NSInteger)index;

@end