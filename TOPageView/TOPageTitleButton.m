//
//  TOPageTitleButton.m
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TOPageTitleButton.h"

@implementation TOPageTitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)buttonLeftView{
    if (!_buttonLeftView) {
        _buttonLeftView = [[UIView alloc] init];
        _buttonLeftView.userInteractionEnabled = NO;
    }
    return _buttonLeftView;
}

- (UIView *)buttonRightView{
    if (!_buttonRightView) {
        _buttonRightView  = [[UIView alloc] init];
        _buttonRightView.userInteractionEnabled = NO;

    }
    return _buttonRightView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result) {
        
        result = [self.buttonLeftView pointInside:[self.buttonLeftView convertPoint:point fromView:self] withEvent:event];
    }
    if (!result) {
        result = [self.buttonRightView pointInside:[self convertPoint:point toView:self.buttonRightView] withEvent:event];
    }
    if (result) {
        
    }
    return result;
}

@end
