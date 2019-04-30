//
//  TOPageTitleView.h
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPageItem.h"

typedef enum : NSUInteger {
    TOPageTitleAlignAverage,
    TOPageTitleAlignLeft,
    TOPageTitleAlignRight,
    TOPageTitleAlignMiddle,
} TOPageTitleAlign;

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
/**
 All items
 */
@property (nonatomic,copy)NSArray<TOPageItem *> *titles;

/**
 The index of selected button.
 -1 means nothing selected.
 */
@property (nonatomic,assign) NSInteger selectedIndex;


/**
 The item of selected button.
 */
@property (nonatomic,readonly) TOPageItem *selectedItem;

/**
 All buttons created.
 */
@property (nonatomic,readonly,copy) NSArray<UIButton *> *buttons;

/**
 This is an indicator on selected button. You can add cornerRadius, dropShadow, mask...
 */
@property (nonatomic,readonly) UIImageView *indicatorView;

#pragma mark - Style
/**
 Edge insets of titles. default {0,0,0,0}
 */
@property (nonatomic,assign) UIEdgeInsets contentInsets;


/**
 MinGap is the maxmum value between buttons, default is 10.0f
 */
@property (nonatomic,assign) CGFloat miniGap;




/**
 Align of buttons.
 */
@property (nonatomic,assign) TOPageTitleAlign align;

/**
 TitleColor of button title with buttonStatusNomarl.
 default blackColor
 */
@property (nonatomic,strong) UIColor *titleColor;


/**
 TitleColor of button title with buttonStatusSelected.
 default 0x1889E6
 */
@property (nonatomic,strong) UIColor *selectedTitleColor;


/**
 TitleColor of button title with buttonStatusHighlightedl.
 Default nil, means this color is mixture of titleColor and selectedTitleColor
 */
@property (nonatomic,strong) UIColor *highlightedTitleColor;


/**
 TextFont of button title with buttonStatusNormal. default system font 14
 */
@property (nonatomic,strong) UIFont *textFont;

/**
 TextFont of button title with buttonStatusSelected. default system font 16
 */
@property (nonatomic,strong) UIFont *selectedTextFont;



#pragma mark - Indicator style
/**
 Color of indicator, default 0x1889E6
 */
@property (nonatomic,strong) UIColor *indicatorColor;

/**
 Height of indicator, default 4.0f.
 */
@property (nonatomic,assign) CGFloat indicatorHeight;


/**
 Edge insets of indicator, default {0,0,0,0}.
 */
@property (nonatomic,assign) UIEdgeInsets indicatorEdgeInsets;


#pragma mark - methods
- (void)setNeedsUpdateButtons;
- (void)setTitles:(NSArray<TOPageItem *> *)titles index:(NSUInteger)index;

@end
