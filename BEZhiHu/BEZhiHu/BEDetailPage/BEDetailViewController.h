//
//  BEDetailViewController.h
//  BEZhiHu
//
//  Created by ihefe26 on 16/1/19.
//  Copyright © 2016年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEDetailViewController : UIViewController


@property (nonatomic, strong) UIImageView *imageViewBE;

@property (nonatomic, strong) UIWebView *webViewBE;

-(void)initImageViewBEAndWebViewBEByID:(NSString *)noteID;


@end
