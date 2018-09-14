//
//  UITextField+GTExtend.h
//  MoCaiRegimental
//
//  Created by timtian on 2018/8/29.
//  Copyright © 2018年 timtian. All rights reserved..
//

#import <UIKit/UIKit.h>

@protocol TTTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (GTExtend)

@property (weak, nonatomic) id <TTTextFieldDelegate> delegate;

@end

/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const TTTextFieldDidDeleteBackwardNotification;
