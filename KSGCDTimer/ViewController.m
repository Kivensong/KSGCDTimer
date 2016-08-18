//
//  ViewController.m
//  KSGCDTimer
//
//  Created by kivensong on 16/8/17.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+GCDTimer.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(self);
    [self scheduledDispatchTimerWithName:@"testTimer" timeInterval:1.0 queue:dispatch_get_main_queue() repeats:YES actionOption:KSGCDTimerAction_CancelPrevious action:^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        weakSelf.testLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
