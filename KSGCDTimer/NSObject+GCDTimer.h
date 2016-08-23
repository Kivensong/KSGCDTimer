//
//  NSObject+GCDTimer.h
//  KSGCDTimer
//
//  Created by kivensong on 16/8/17.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WEAKSELF(obj) __weak typeof(obj) weakSelf = obj;

@interface NSObject (KSGCDTimer)
/**
 *    开始计时
 *
 *    @param timerName 自定义的timer的名称
 *    @param interval  计时时长单位是second
 *    @param queue     timer将被放入的队列，也就是最终action执行的队列。传入nil将自动放到一个子线程队列中
 *    @param repeats   是否循环调用
 *    @param action    回调block
 */
- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                                action:(dispatch_block_t)action;

/**
 *    计时任务，延迟段时间执行某个操作
 *
 *    @param interval 延迟时长 单位是second
 *    @param queue    任务被放置的队列，也就是aciton执行队列，传入nil则自动启动一个子线程队列中。
 *    @param action   任务block
 */
- (void)scheduledTaskAfterInterval:(double)interval
                             queue:(dispatch_queue_t)queue
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
