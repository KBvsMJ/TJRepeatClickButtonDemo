//
//  UIButton+RepeatClick.m
//  TJRepeatClickButtonDemo
//
//  Created by ebaotong on 16/3/21.
//  Copyright © 2016年 com.csst. All rights reserved.
//

#import "UIButton+RepeatClick.h"
#import <objc/runtime.h>
static const void * TJ_ClickButton_TimeIntervalKey = "TJ_ClickButton_TimeIntervalKey";

static const void * TJ_Temp_ClickButton_TimeIntervalKey = "TJ_Temp_ClickButton_TimeIntervalKey";



@interface UIButton ()

@property(nonatomic,assign) NSTimeInterval tempTimeInterval;

@end

@implementation UIButton (RepeatClick)

- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, TJ_ClickButton_TimeIntervalKey, @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (NSTimeInterval)timeInterval
{
    return [objc_getAssociatedObject(self, TJ_ClickButton_TimeIntervalKey) doubleValue];

}

- (void)setTempTimeInterval:(NSTimeInterval)tempTimeInterval
{
    objc_setAssociatedObject(self, TJ_Temp_ClickButton_TimeIntervalKey, @(tempTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);


}

- (NSTimeInterval)tempTimeInterval
{
    return [objc_getAssociatedObject(self, TJ_Temp_ClickButton_TimeIntervalKey) doubleValue];

}

+ (void)load
{
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(sendNewAction:to:forEvent:);
        Method methodA = class_getInstanceMethod(self, selA);
        Method methodB = class_getInstanceMethod(self, selB);
        
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        
        if (isAdd){
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }
        else{
            method_exchangeImplementations(methodA, methodB);
        }
    });

}


- (void)sendNewAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{

    if (NSDate.date.timeIntervalSince1970 - self.tempTimeInterval<self.timeInterval) {
        return;
    }
    if (self.timeInterval>0) {
        self.tempTimeInterval = NSDate.date.timeIntervalSince1970;
    }
    
    
    [self sendNewAction:action to:target forEvent:event];
    
    
}










@end
