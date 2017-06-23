//
//  AutoLayoutHelper.h
//  TOPageView
//
//  Created by Tony on 17/6/20.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AutoLayoutHelper : NSObject

+ (NSArray<NSLayoutConstraint *> *)constraintsWithPaddingLeftRight:(UIView *)view;
+ (NSArray<NSLayoutConstraint *> *)createConstaints:(UIView *)view paddingLeft:(UIView *)leftView leftOffset:(CGFloat)leftOffset paddingRight:(UIView *)rightView rightOffset:(CGFloat)rightOffset;

//update constraints
+ (void)updateConstraints:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant ;

@end
