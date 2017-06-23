//
//  AutoLayoutHelper.m
//  TOPageView
//
//  Created by Tony on 17/6/20.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "AutoLayoutHelper.h"

@implementation AutoLayoutHelper

+ (NSArray<NSLayoutConstraint *> *)constraintsWithPaddingLeftRight:(UIView *)view{
    NSMutableArray *result = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in view.superview.constraints) {
        if (constraint.firstItem == view) {
            if (constraint.firstAttribute == NSLayoutAttributeLeft || constraint.firstAttribute == NSLayoutAttributeRight) {
                [result addObject:constraint];
            }
        }else if (constraint.secondItem == view){
            if (constraint.secondAttribute == NSLayoutAttributeLeft || constraint.secondAttribute == NSLayoutAttributeRight) {
                [result addObject:constraint];
            }
        }
    }
    return result;
}

+ (void)updateConstraints:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant{
    for (NSLayoutConstraint *constraint in view.superview.constraints) {
        if (constraint.firstItem == view) {
            if (constraint.firstAttribute == attribute) {
                constraint.constant = constant;
            }
        }else if (constraint.secondItem == view) {
            if (constraint.secondAttribute == attribute) {
                constraint.constant = constant;
            }
        }
    }
}

+ (NSArray<NSLayoutConstraint *> *)createConstaints:(UIView *)view paddingLeft:(UIView *)leftView leftOffset:(CGFloat)leftOffset paddingRight:(UIView *)rightView rightOffset:(CGFloat)rightOffset{
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute: NSLayoutAttributeLeft multiplier:1 constant:leftOffset];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute: NSLayoutAttributeRight multiplier:1 constant:rightOffset];
    
    return @[leftConstraint,rightConstraint];
}

@end
