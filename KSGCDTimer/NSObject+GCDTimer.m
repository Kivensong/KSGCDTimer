//
//  NSObject+GCDTimer.m
//  KSGCDTimer
//
//  Created by kivensong on 16/8/17.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "NSObject+GCDTimer.h"
#import <objc/runtime.h>

@interface NSObject ()
@property (nonatomic, strong) NSMutableDictionary* timerDictionary;
@end

@implementation NSObject (KSGCDTimer)

- (void) scheduledDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action
{
    if (nil == timerName)
        return;
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerDictionary objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerDictionary setObject:timer forKey:timerName];
    }
    
    /* timer精度为0.1秒 */
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    WEAKSELF(self);
    dispatch_source_set_event_handler(timer, ^{
        action();
        if (!repeats) {
            [weakSelf cancelTimerWithName:timerName];
        }
    });
}

- (void)cancelTimerWithName:(NSString *)timerName
{
    dispatch_source_t timer = [self.timerDictionary objectForKey:timerName];
    
    if (!timer) {
        return;
    }
    
    [self.timerDictionary removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}

- (void)cancelAllTimer
{
    [self.timerDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *timerName, dispatch_source_t timer, BOOL *stop) {
        dispatch_source_cancel(timer);
    }];
    
    [self.timerDictionary removeAllObjects];
}


- (BOOL)existOfTimerName:(NSString *)timerName
{
    return [self.timerDictionary objectForKey:timerName] != nil;
}

- (NSMutableDictionary* ) timerDictionary
{
    NSMutableDictionary* dictionary = objc_getAssociatedObject(self, @selector(timerDictionary));
    if (dictionary) {
        return dictionary;
    }
    
    dictionary = [NSMutableDictionary dictionary];
    self.timerDictionary = dictionary;
    return dictionary;
}

- (void) setTimerDictionary:(NSMutableDictionary *)timerDictionary
{
    objc_setAssociatedObject(self, @selector(timerDictionary), timerDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
