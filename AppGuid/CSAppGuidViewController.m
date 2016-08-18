//
//  CSAppGuidViewController.m
//  AppGuid
//
//  Created by Shaochong Du on 16/7/20.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//


#define CSAppGuidDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define CSGuidRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define CSMainScreenSize [UIScreen mainScreen].bounds.size

#import "CSAppGuidViewController.h"
#import "AppDelegate.h"
#import "UIView+Addition.h"

@interface CSAppGuidViewController ()<UIScrollViewDelegate>
{
    NSArray *_imgArray;
    CSGuidCompleteBlock _completeBlock;
}
@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation CSAppGuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    self.currentPage = 0;
    
    [self setupViews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CSAppGuidViewController *)initWithLunchImgArray:(NSArray *)imgArray complete:(CSGuidCompleteBlock)block
{
    if (self = [super init]) {
        _imgArray = imgArray;
        _completeBlock = block;
    }
    return self;
}

- (void)setupViews
{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.contentScrollView.pagingEnabled = YES;
//    self.contentScrollView.showsHorizontalScrollIndicator = YES;
    self.contentScrollView.bounces = NO;
//    self.contentScrollView.backgroundColor = [self randomColor];
    self.contentScrollView.contentSize = CGSizeMake(CSMainScreenSize.width * (_imgArray.count + 1), CSMainScreenSize.height);
    self.contentScrollView.delegate = self;
    [self.view addSubview:self.contentScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
//    self.pageControl.backgroundColor = [self randomColor];
    self.pageControl.bottom = CSMainScreenSize.height - 60;
    self.pageControl.centerX = self.view.centerX;
    self.pageControl.numberOfPages = _imgArray.count;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = CSGuidRGBA(255,86,64, 1.0);
    self.pageControl.userInteractionEnabled = NO;
    [self.view addSubview:self.pageControl];
    
    [self addImageView];
}
#pragma mark - 添加imageView到scrollView
- (void)addImageView
{
    for (int i = 0; i < _imgArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * CSMainScreenSize.width, 0, CSMainScreenSize.width, CSMainScreenSize.height)];
        imageView.image = [UIImage imageNamed:_imgArray[i]];
        [self.contentScrollView addSubview:imageView];
        if (i == _imgArray.count - 1)
        {
            [self addStartBtnWithImgView:imageView];
        }
    }
}

//  添加开始按钮
- (void)addStartBtnWithImgView:(UIImageView *)imgView
{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(0, 0, 120, 30);
    startBtn.top = self.pageControl.bottom + 10;
    startBtn.centerX = self.view.centerX;
    [startBtn setTitle:@"开启优活动" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.clipsToBounds = YES;
    startBtn.layer.cornerRadius = 3.0;
    [startBtn addTarget:self action:@selector(hiddenGuidView) forControlEvents:UIControlEventTouchUpInside];
    startBtn.backgroundColor = [self randomColor];
    UIColor *normalColor = CSGuidRGBA(224,49,36, 1.0);
    UIColor *highlighedColor = CSGuidRGBA(255,86,64, 1.0);
    [startBtn setBackgroundImage:[self imageWithColor:normalColor] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[self imageWithColor:highlighedColor] forState:UIControlStateHighlighted];
    
    imgView.userInteractionEnabled = YES;
    [imgView addSubview:startBtn];
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentsetX = scrollView.contentOffset.x;
    self.currentPage = (int)contentsetX / CSMainScreenSize.width + 0.5;
    self.pageControl.currentPage = self.currentPage;
    if (self.currentPage == _imgArray.count) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPage = scrollView.contentOffset.x / CSMainScreenSize.width;
    if (self.currentPage == _imgArray.count) {
        [self hiddenGuidView];
    }
}

#pragma mark - show
- (void)showGuidView
{
//    self.view.alpha = 0.0f;
    //  使用present方法弹出页面时
    UIViewController *topVC = CSAppGuidDelegate.window.rootViewController;
    if (CSAppGuidDelegate.window.rootViewController.presentedViewController) {
        topVC = CSAppGuidDelegate.window.rootViewController.presentedViewController;
    }
    
    [topVC addChildViewController:self];
    [topVC.view addSubview:self.view];
    
//    [UIView animateWithDuration:0.25f animations:^{
//        self.view.alpha = 1.0f;
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)hiddenGuidView
{
    if (_completeBlock) {
        _completeBlock();
    }
    [UIView animateWithDuration:0.25f animations:^{
        self.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

- (UIColor *)randomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    return color;
    
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
