//
//  ViewController.m
//  AppGuid
//
//  Created by Shaochong Du on 16/7/20.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//

#import "ViewController.h"
#import "CSAppGuidViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGuid:(id)sender
{
    CSAppGuidViewController *guidVC = [[CSAppGuidViewController alloc] initWithLunchImgArray:@[@"guies01",@"guies02",@"guies03"] complete:^{
        NSLog(@"ViewController 引导页结束");
    }];
    [guidVC showGuidView];
}
@end
