//
//  GCDViewController.m
//  Primary
//
//  Created by Phil Xhc on 15/11/9.
//  Copyright © 2015年 Xhc. All rights reserved.
//
/*
 serial -->连续的
 caret -->脱字符号.
 concurrent-->并发的.
 */

#import "GCDViewController.h"
#import "GCDAPIVC.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [self philInitUI];
    [self introduceOne];
    [self introduceTwo];
    [self principleAnalysis];
}
- (void)philInitUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0.f, NAVBAR_HEIGHT , 80.f, 80.f);
    [btn setTitle:@"GCDAPI" forState:0];
    [btn addTarget:self action:@selector(GCDAPI) forControlEvents:1<<6];
    [self.view addSubview:btn];
}
- (void)GCDAPI{
    GCDAPIVC *vc = [[GCDAPIVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)principleAnalysis{
    /*
     OS X ios根据用户的知识启动应用程序后,首先便将包含在应用程序中的CPU命令列配置到内存中.
     CPU从应用程序指定的地址开始,一个一个执行CPU命令列
     在OC的控制函数语句调用情况下,执行命令列的地址会原理当前的位置(位置前移).
     但是由于一个CPU一次只能执行一次命令,不能执行某处分开的并列的两个命令.即平行关系,执行不会出现分歧.
     这里所谓一个CPU执行的CPU命令为一条无分叉的路径----->线程.
     
     而对于屋里的CPU芯片为64核.64个CPU 一个CPU核执行多条不同
     
     一个CPU核一次能够执行的CPU命令始终为1.
        OSX和iOS的核心XNU内核在发生操作系统时间时(如每隔一段时间,唤起系统调用的情况,)会切换路径/.
     执行中路径的状态改变,
    例如CPU的寄存器等信息保存到各自路径专用的内存块中,从切换目标路径专用的内存块中,复原CPU寄存器等信息,继续执行切换路径的CPU命令.被称之为上下文切换.
    由于使用多线程的程序可以在某个线程和其他线程之间甘谷多次进行上下文切换,(切换执行路径,看上去好像1个CPU核能够并列地执行多个线程一样.而且在具有多个CPU核的情况下,就放佛是真的提供了多个CPU核并执行多个线程的技术.)
     //而上述就是"多线程编程.".
     multi-thread problem.
        1.更新相同的资源导致数据的不一致-->数据竞争.
        2.停止等待事件的线程会导致多个线程相互持续等待(死锁).(死循环.)
        3.使用太多线程会大量消耗内存.
     multi-thread.
        应用程序在启动时,通过最先执行的线程.即"主线程"来描绘用户界面,处理屏幕的事件等.在主线程中是绝对不能进行长时间处理得(如AR用画像的识别,或数据库访问.)就会妨碍主线程的执行.(阻塞.).在OSX和iOS的应用程序中,会妨碍主线程中被称为RunLoop的主循环的执行.从而导致不能更新用户界面,应用程序的画面长时间停滞等问题.
     //故-->长时间的处理不能放在主线程中执行,在其他线程中执行.
     */
}


//GCD
- (void)introduceOne{
    
    //A string label to attach to the queue to uniquely identify it in debugging tools such as Instruments, sample, stackshots, and crash reports
    dispatch_queue_t queue = dispatch_queue_create("uniquely identify", nil);
    dispatch_async(queue, ^{
       /*
        长时间处理
        AR用画像识别.
        数据库访问.
        等长时间处理结束之后,主线程使用该处理结果.
        */
        dispatch_async(dispatch_get_main_queue(), ^{
           /*
            只在主线程可以执行的处理.
            如UI更新.
            */
        });
        
    });
}
//NSThread.
- (void)introduceTwo{
    /*
     NSObject performSelectorInBackground:withObject:方法中.
     //在此方法执行后台线程.
     */
}
- (void) launchThreadByNSobject_performSelectorInBackground_withObject{
    [self performSelectorInBackground:@selector(doWork) withObject:nil];
}
- (void) doWork{
    /*
     长时间处理的方法.
     */
    [self performSelectorOnMainThread:@selector(doneWork) withObject:nil waitUntilDone:YES];
}
- (void) doneWork{
    /*
     只在主线程中处理结果.
     */
}


@end
