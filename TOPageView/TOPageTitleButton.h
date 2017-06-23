//
//  TOPageTitleButton.h
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPageTitleButton : UIButton

@property (nonatomic,strong) UIView *buttonLeftView;
@property (nonatomic,strong) UIView *buttonRightView;
@property (nonatomic,assign) NSUInteger buttonIndex;

@end
