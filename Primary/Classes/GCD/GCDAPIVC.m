//
//  GCDAPIVC.m
//  Primary
//
//  Created by Phil Xhc on 15/11/9.
//  Copyright © 2015年 Xhc. All rights reserved.
//

/*
 3.2 GCD的API
 */
#import "GCDAPIVC.h"

@interface GCDAPIVC ()

@end

@implementation GCDAPIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [self introduceDispatchQueue];
}

- (void)introduceDispatchQueue{
//    DISPATCH_QUEUE_SERIAL--->连续的执行.等待处理结束
//    DISPATCH_QUEUE_CONCURRENT--->不等待处理结束.
//    dispatch_queue_t queue = DISPATCH_QUEUE_SERIAL;
    dispatch_queue_t queueSerial = dispatch_queue_create("GCDAPIVCTestSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queueConcurrent = dispatch_queue_create("GCDAPIVCTestConcurrent", DISPATCH_QUEUE_CONCURRENT);
    //串行执行,当前面一个执行完,才会执行这一个.
    dispatch_async(queueSerial, ^{
        NSLog(@"1");
    });
    dispatch_async(queueSerial, ^{
        NSLog(@"2");
    });
    dispatch_async(queueSerial, ^{
        NSLog(@"3");
    });
    //并行执行,不等待前面一个是否执行,可以并行执行多个处理.并行执行的处理数量取决于当前系统的状态.
    dispatch_async(queueConcurrent, ^{
        NSLog(@"4");
    });
    dispatch_async(queueConcurrent, ^{
        NSLog(@"5");
    });
    dispatch_async(queueConcurrent, ^{
        NSLog(@"6");
    });
    dispatch_async(queueConcurrent, ^{
        NSLog(@"7");
    });
    dispatch_async(queueConcurrent, ^{
        NSLog(@"8");
    });
    dispatch_async(queueConcurrent, ^{
        NSLog(@"9");
    });
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
