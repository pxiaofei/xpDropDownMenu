//
//  ViewController.m
//  TestView
//
//  Created by 清欢有味 on 15/11/28.
//  Copyright © 2015年 清欢有味. All rights reserved.
//

#import "ViewController.h"
#import "XPDropDown.h"

@interface ViewController ()<XPDropDownDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    XPDropDown *drop = [[XPDropDown alloc]initWithFrame:CGRectMake(20, 100, 200, 44) tableHeight:200 dataArr:arr];
    drop.delegate = self;
    drop.btnBackgroundColor = [UIColor redColor];
    drop.titleColor = [UIColor orangeColor];
    drop.cornerRadius = 8;
    [self.view addSubview:drop];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) xpDropDownDelegateMethod:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}
@end
