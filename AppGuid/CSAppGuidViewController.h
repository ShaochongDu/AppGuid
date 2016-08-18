//
//  CSAppGuidViewController.h
//  AppGuid
//
//  Created by Shaochong Du on 16/7/20.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//
//  app引导页
typedef void(^CSGuidCompleteBlock)(void);

#import <UIKit/UIKit.h>

@interface CSAppGuidViewController : UIViewController

- (CSAppGuidViewController *)initWithLunchImgArray:(NSArray *)imgArray complete:(CSGuidCompleteBlock)block;

- (void)showGuidView;

@end
