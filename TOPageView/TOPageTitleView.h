//
//  TOPageTitleView.h
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPageItem.h"

@class TOPageTitleView;


@protocol TOPageTitleViewDelegate <NSObject>

@optional
- (BOOL)pageTitleView:(TOPageTitleView *)pageTitleView shouldSelectedIndex:(NSUInteger)index;
- (void)pageTitleView:(TOPageTitleView *)pageTitleView didSelecteIndex:(NSInteger)index oldIndex:(NSInteger)index;
- (void)pageTitleView:(TOPageTitleView *)pageTitleView willShowButton:(UIButton *)button forItem:(TOPageItem *)item;

@end

@interface TOPageTitleView : UIView

@property (nonatomic,assign) id<TOPageTitleViewDelegate> titleViewDelegate;

#pragma mark - Params
//if array is empty, selectedIndex == -1
@property (nonatomic,copy)NSArray<TOPageItem *> *titles;
//-1 means no item selected
@property (nonatomic,assign)IBInspectable NSInteger selectedIndex;
@property (nonatomic,readonly) TOPageItem *selectedItem;

//Buttons list
@property (nonatomic,readonly,copy) NSArray<UIButton *> *buttons;
//Indicator view
@property (nonatomic,readonly) UIImageView *indicatorView;

#pragma mark - Style
@property (nonatomic,assign)IBInspectable UIEdgeInsets contentInsets;
//miniGap is the minimum value between buttons, default is 10.0f
@property (nonatomic,assign)IBInspectable CGFloat miniGap;
//default blackColor
@property (nonatomic,strong)IBInspectable UIColor *titleColor;
//default 0x1889E6
@property (nonatomic,strong)IBInspectable UIColor *selectedTitleColor;
//if null, the color is mixture of titleColor and titleColor
@property (nonatomic,strong)IBInspectable UIColor *highlightedTitleColor;

//default system font 14
@property (nonatomic,strong)IBInspectable UIFont *textFont;
//default system font 16
@property (nonatomic,strong)IBInspectable UIFont *selectedTextFont;


//Indicator style
//default 0x1889E6
@property (nonatomic,strong)IBInspectable UIColor *indicatorColor;
//default 4.0f
@property (nonatomic,assign)IBInspectable CGFloat indicatorHeight;
//default {0,0,0,0}
@property (nonatomic,assign)IBInspectable UIEdgeInsets indicatorEdgeInsets;


#pragma mark - methods
- (void)setNeedsUpdateButtons;

@end
