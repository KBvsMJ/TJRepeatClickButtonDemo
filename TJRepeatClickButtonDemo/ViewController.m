//
//  ViewController.m
//  TJRepeatClickButtonDemo
//
//  Created by ebaotong on 16/3/21.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+RepeatClick.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnRepeat;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_btnRepeat addTarget:self action:@selector(clickWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    _btnRepeat.timeInterval = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clickWithBtn:(UIButton *)sender
{
    NSLog(@"test");
    
}
@end
