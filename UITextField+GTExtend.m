//
//  UITextField+GTExtend.m
//  MoCaiRegimental
//
//  Created by timtian on 2018/8/29.
//  Copyright © 2018年 timtian. All rights reserved.
//

#import "UITextField+GTExtend.h"
#import <objc/runtime.h>

NSString * const TTTextFieldDidDeleteBackwardNotification = @"textfield_did_notification";

@implementation UITextField (GTExtend)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(tt_deleteBackward));
    method_exchangeImplementations(method1, method2);
    //! 下面这个交换主要解决大于等于8.0小于8.3系统不调用deleteBackward的问题
    
    Method method3 = class_getInstanceMethod([self class], NSSelectorFromString(@"keyboardInputShouldDelete:"));
    Method method4 = class_getInstanceMethod([self class], @selector(tt_keyboardInputShouldDelete:));
    method_exchangeImplementations(method3, method4);
}

- (void)tt_deleteBackward {
    [self tt_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <TTTextFieldDelegate> delegate  = (id<TTTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TTTextFieldDidDeleteBackwardNotification object:self];
}

- (BOOL)tt_keyboardInputShouldDelete:(UITextField *)textField {
    BOOL shouldDelete = [self tt_keyboardInputShouldDelete:textField];
    BOOL isMoreThanIos8_0 = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f);
    BOOL isLessThanIos8_3 = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.3f);
    if (![textField.text length] && isMoreThanIos8_0 && isLessThanIos8_3) {
        [self deleteBackward];
    }

    return shouldDelete;
    
}



@end
