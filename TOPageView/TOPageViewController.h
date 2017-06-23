//
//  TOPageViewController.h
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPageTitleView.h"


@interface TOPageViewController : UIViewController

@property (nonatomic,readonly) TOPageTitleView *titleView;
@property (nonatomic,readonly) UIPageViewController *pageViewController;

@property (nonatomic,copy) NSArray<TOPageItem *> *itemList;

@property (nonatomic,assign) NSInteger selectedIndex;


@end
