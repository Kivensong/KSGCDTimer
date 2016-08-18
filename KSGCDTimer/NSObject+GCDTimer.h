//
//  NSObject+GCDTimer.h
//  KSGCDTimer
//
//  Created by kivensong on 16/8/17.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WEAKSELF(obj) __weak typeof(obj) weakSelf = obj;

typedef NS_ENUM(NSUInteger, KSGCDTimerAction)
{
    KSGCDTimerAction_CancelPrevious, //取消之前同名的计时器block回调，并且重新开始计时
    KSGCDTimerAction_MergePrevious,  //合并timer,相当于给timer添加了另一个block回调，并且重新计时
};

@interface NSObject (KSGCDTimer)
/**
 *    开始计时任务
 *
 *    @param timerName 自定义的timer的名称
 *    @param interval  计时时长单位是second
 *    @param queue     timer将被放入的队列，也就是最终action执行的队列。传入nil将自动放到一个子线程队列中
 *    @param repeats   是否循环调用
 *    @param option    多次schedule同一个timer时的操作选项
 *    @param action    回调block
 */
- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                          actionOption:(KSGCDTimerAction)option
                                action:(dispatch_block_t)action;
/**
 *    取消timer
 *
 *    @param timerName timer的名称
 */
- (void)cancelTimerWithName:(NSString *)timerName;

/**
 *    取消所有的timer
 */
- (void)cancelAllTimer;

/**
 *    判断某个计时器是否存在
 *
 *    @param timerName timer名称
 *
 *    @return 是否存在
 */
- (BOOL)existOfTimerName:(NSString *)timerName;

@end
