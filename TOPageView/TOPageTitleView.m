//
//  TOPageTitleView.m
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TOPageTitleView.h"
#import "TOPageTitleButton.h"
#import <objc/message.h>
#import "AutoLayoutHelper.h"

#define TO_PAGE_ANIMATE_DURATION .2f

@interface TOPageTitleView (){
    //flag
    BOOL _needsUpdateButtons;
    BOOL _needsUpdateIndicator;
    
    NSMutableArray<TOPageTitleButton *> *_buttons;
    UIImageView *_indicatorView;
    UIColor *_indicatorColor;
    NSArray<TOPageItem *> *_titles;
}

@property (nonatomic,strong) UIScrollView *titleScrollView;
@property (nonatomic,strong) UIView *titleContentView;

@end

IB_DESIGNABLE
@implementation TOPageTitleView

- (CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}

#pragma mark - Life Cycle
- (void)prepareForInterfaceBuilder{
    [self config];
    self.titles = [NSMutableArray arrayWithArray:@[
                                                   [TOPageItem itemWithTitle:@"母婴"],
                                                   [TOPageItem itemWithTitle:@"美妆"],
                                                   [TOPageItem itemWithTitle:@"保健"],
                                                   [TOPageItem itemWithTitle:@"服饰"],
                                                   [TOPageItem itemWithTitle:@"食品"],
                                                   [TOPageItem itemWithTitle:@"百货"],
                                                   [TOPageItem itemWithTitle:@"数码"],
                                                   ]];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self config];
}

- (instancetype)init{
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)config{
    _miniGap = 10.0f;
    _indicatorHeight = 4.0f;
    _buttons = [NSMutableArray array];
    [self configUI];
    _selectedIndex = -1;
}

- (void)configUI{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addSubview:self.titleScrollView];
    [self.titleScrollView addSubview:self.titleContentView];
    
    
    [self.titleContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = @{
                            @"scrollView":self.titleScrollView,
                            @"contentView":self.titleContentView
                            };
    
    //config scrollView
    NSArray<NSLayoutConstraint *> *hConstraints = [NSLayoutConstraint
                                                   constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                   options:0 metrics:nil
                                                   views:views
                                                   ];
    [self addConstraints:hConstraints];
    NSArray<NSLayoutConstraint *> *vConstraints = [NSLayoutConstraint
                                                   constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                   options:0 metrics:nil
                                                   views:views
                                                   ];
    [self addConstraints:vConstraints];
    
    //config contentView
    hConstraints = [NSLayoutConstraint
                    constraintsWithVisualFormat:@"H:|[contentView(>=scrollView)]|"
                    options:0 metrics:nil
                    views:views
                    ];
    [self.titleScrollView addConstraints:hConstraints];
    vConstraints = [NSLayoutConstraint
                    constraintsWithVisualFormat:@"V:|[contentView(==scrollView)]|"
                    options:0 metrics:nil
                    views:views
                    ];
    [self.titleScrollView addConstraints:vConstraints];
    
    
}


#pragma mark - Getter
- (TOPageItem *)selectedItem{
    if (_selectedIndex >= 0 && _selectedIndex < _titles.count) {
        return _titles[_selectedIndex];
    }else{
        return nil;
    }
}

- (UIView *)titleContentView{
    if (!_titleContentView) {
        _titleContentView = [[UIView alloc] init];
    }
    return _titleContentView;
}

- (UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _titleScrollView;
}

- (UIImageView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIImageView alloc] init];
        _indicatorView.backgroundColor = self.indicatorColor;
    }
    return _indicatorView;
}

- (NSArray<TOPageItem *> *)titles{
    if (!_titles) {
        _titles = [NSArray array];
    }
    return _titles;
}

- (NSMutableArray<TOPageTitleButton *> *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    @synchronized (_buttons) {
        return [_buttons copy];
    }
}

- (UIEdgeInsets)contentInsets{
    return self.titleScrollView.contentInset;
}

- (UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

- (UIColor *)indicatorColor{
    if (!_indicatorColor) {
        
        _indicatorColor = [UIColor colorWithRed:0x18/255.0 green:0x89/255.0 blue:0xE6/255.0 alpha:1];
    }
    return _indicatorColor;
}

- (UIColor *)selectedTitleColor{
    if (!_selectedTitleColor) {
        _selectedTitleColor = [UIColor colorWithRed:0x18/255.0 green:0x89/255.0 blue:0xE6/255.0 alpha:1];
    }
    return _selectedTitleColor;
}

- (UIColor *)highlightedTitleColor{
    if (!_highlightedTitleColor) {
        const CGFloat *c1 = CGColorGetComponents(self.titleColor.CGColor);
        const CGFloat *c2 = CGColorGetComponents(self.selectedTitleColor.CGColor);
        
        return  [UIColor colorWithRed:(c1[0]+c2[0])/2
                                green:(c1[1]+c2[1])/2
                                 blue:(c1[2]+c2[2])/2
                                alpha:(c1[3]+c2[3])/2];
        
    }
    return _highlightedTitleColor;
}

- (UIFont *)textFont{
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:14];
    }
    return _textFont;
}

#pragma mark - Setter
- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    self.titleScrollView.contentInset = contentInsets;
}

- (void)setMiniGap:(CGFloat)miniGap{
    @synchronized (_buttons) {
        _miniGap = miniGap;
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    _indicatorView.backgroundColor = indicatorColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (_selectedIndex == selectedIndex) {
        return;
    }
    
    [self layoutIfNeeded];

    
    NSArray<TOPageTitleButton *> *buttons = (NSArray<TOPageTitleButton *> *)self.buttons;
    TOPageTitleButton *selectedButton;
    for (TOPageTitleButton *button in buttons) {
        if (button.buttonIndex == selectedIndex) {
            button.selected = YES;
            button.titleLabel.font = self.selectedTextFont;
            selectedButton = button;
        }else{
            button.selected = NO;
            button.titleLabel.font = self.textFont;
        }
    }
    
    BOOL animation = _selectedIndex >= 0 && self.superview;
    
    if(selectedIndex >= 0){
        self.indicatorView.hidden = NO;
    }else{
        self.indicatorView.hidden = YES;
    }

    _selectedIndex = selectedIndex;
    
    [self setNeedsUpdateIndicator];
    
    if (animation) {
        [UIView animateWithDuration:TO_PAGE_ANIMATE_DURATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self layoutIfNeeded];
            
        } completion:nil];
        
        if (selectedButton) {
            [UIView animateWithDuration:TO_PAGE_ANIMATE_DURATION delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGFloat offsetX = selectedButton.frame.origin.x + selectedButton.frame.size.width/2 - self.frame.size.width/2;
                if (offsetX < 0) {
                    offsetX = 0;
                }
                if (offsetX >self.titleScrollView.contentSize.width - self.frame.size.width) {
                    offsetX = self.titleScrollView.contentSize.width - self.frame.size.width;
                }
                self.titleScrollView.contentOffset = CGPointMake(offsetX, 0);
            } completion:nil];
        }
    }
    
}

- (void)setTitles:(NSArray<TOPageItem *> *)titles index:(NSUInteger)index{
    
    _titles = [titles copy];
    [self setNeedsUpdateButtons];
    
    if (index != NSNotFound) {
        _selectedIndex = index;
    }else if (titles.count > 0) {
        if (_selectedIndex < 0) {
            _selectedIndex = 0;
        }
        NSInteger maxIndex = titles.count-1;
        if (_selectedIndex > maxIndex) {
            _selectedIndex = maxIndex;
        }
    }else{
        _selectedIndex = -1;
    }
}

- (void)setTitles:(NSArray<TOPageItem *> *)titles{
    NSUInteger index = [titles indexOfObject:self.selectedItem];
    [self setTitles:titles index:index];
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight{
    _indicatorHeight = indicatorHeight;
    [self setNeedsUpdateIndicator];
}

- (void)setIndicatorEdgeInsets:(UIEdgeInsets)indicatorEdgeInsets{
    _indicatorEdgeInsets = indicatorEdgeInsets;
    [self setNeedsUpdateIndicator];
}


#pragma mark - Override
- (void)updateConstraints{
    if (_needsUpdateButtons) {
        _needsUpdateButtons = NO;
        _needsUpdateIndicator = YES;
        [self updateButtons];
    }
    
    if (_needsUpdateIndicator) {
        _needsUpdateIndicator = NO;
        [self updateIndicator];
    }
    [super updateConstraints];
}

#pragma mark - Private
- (void)updateButtons{
    [self buttons];
    @synchronized (_buttons) {
        [self removeAllButtons];
        [self createButtons];
    }
}

- (void)removeAllButtons{
    for (UIView *view in self.titleContentView.subviews) {
        [view removeFromSuperview];
    }
    [_buttons removeAllObjects];
}

- (void)createButtons{
    
    TOPageTitleAlign align = self.align;
    if (self.titles.count) {
        NSMutableString *hVisualFormat = [NSMutableString string];
        
        UIView *spaceView;
        NSMutableDictionary *views = [NSMutableDictionary dictionary];
        for (int i=0; i<self.titles.count; i++) {
            TOPageItem *titleItem = self.titles[i];
            TOPageTitleButton *button = [self factoryCreateButton:titleItem];
            button.buttonIndex = i;
            if (i == self.selectedIndex) {
                button.selected = YES;
                button.titleLabel.font = self.selectedTextFont;
            }
            
            [_buttons addObject:button];
            [self.titleContentView addSubview:button];
            [self.titleContentView addSubview:button.buttonLeftView];
            [self.titleContentView addSubview:button.buttonRightView];
            
            [button setTranslatesAutoresizingMaskIntoConstraints:NO];
            [button.buttonLeftView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [button.buttonRightView setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            
            NSString *buttonName = [NSString stringWithFormat:@"button%d",i];
            NSString *buttonLeftName = [NSString stringWithFormat:@"buttonLeft%d",i];
            NSString *buttonRightName = [NSString stringWithFormat:@"buttonRight%d",i];
            
            views[buttonName] = button;
            views[buttonLeftName] = button.buttonLeftView;
            views[buttonRightName] = button.buttonRightView;
            
            //Horizontal layout
            if (!spaceView) {
                spaceView = button.buttonLeftView;
                views[@"space"] = spaceView;
                if (align == TOPageTitleAlignAverage) {
                    if (titleItem.minWidth > 0) {
                        [hVisualFormat appendFormat:@"[%@(>=%f)][%@(>=%f)][%@(==space)]",buttonLeftName,self.miniGap/2,buttonName,titleItem.minWidth,buttonRightName];
                    }else{
                        [hVisualFormat appendFormat:@"[%@(>=%f)][%@][%@(==space)]",buttonLeftName,self.miniGap/2,buttonName,buttonRightName];
                    }
                }else{
                    if (titleItem.minWidth > 0) {
                        [hVisualFormat appendFormat:@"[%@(==%f)][%@(>=%f)][%@(==space)]",buttonLeftName,self.miniGap/2,buttonName,titleItem.minWidth,buttonRightName];
                    }else{
                        [hVisualFormat appendFormat:@"[%@(==%f)][%@][%@(==space)]",buttonLeftName,self.miniGap/2,buttonName,buttonRightName];
                    }
                }
                
            }else{
                if (titleItem.minWidth > 0) {
                    [hVisualFormat appendFormat:@"[%@(==space)][%@(>=%f)][%@(==space)]",buttonLeftName,buttonName,titleItem.minWidth,buttonRightName];
                }else{
                    [hVisualFormat appendFormat:@"[%@(==space)][%@][%@(==space)]",buttonLeftName,buttonName,buttonRightName];
                }
                
            }
            
            //Vertical layout
            NSString *vVisualFormat;
            vVisualFormat = [NSString stringWithFormat:@"V:|[%@]|",buttonName];
            [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vVisualFormat options:0 metrics:nil views:views]];
            
            
            vVisualFormat = [NSString stringWithFormat:@"V:|[%@]|",buttonLeftName];
            [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vVisualFormat options:0 metrics:nil views:views]];
            
            vVisualFormat = [NSString stringWithFormat:@"V:|[%@]|",buttonRightName];
            [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vVisualFormat options:0 metrics:nil views:views]];
        }
        
        switch (align) {
            case TOPageTitleAlignLeft:
                [hVisualFormat insertString:@"H:|" atIndex:0];
                [hVisualFormat appendString:@"-(>=0)-|"];
                break;
            case TOPageTitleAlignRight:
                [hVisualFormat insertString:@"H:|-(>=0)-" atIndex:0];
                [hVisualFormat appendString:@"|"];
                break;
            case TOPageTitleAlignMiddle:
            {
                UIView *leftView = [UIView new];
                UIView *rightView = [UIView new];
                [self.titleContentView addSubview:leftView];
                [self.titleContentView addSubview:rightView];
                
                [leftView setTranslatesAutoresizingMaskIntoConstraints:NO];
                [rightView setTranslatesAutoresizingMaskIntoConstraints:NO];


                views[@"leftView"] = leftView;
                views[@"rightView"] = rightView;

                [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftView]|" options:0 metrics:nil views:views]];
                [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightView]|" options:0 metrics:nil views:views]];


                [hVisualFormat insertString:@"H:|[leftView(>=0)]" atIndex:0];
                [hVisualFormat appendString:@"[rightView(==leftView)]|"];
            }
                break;
            case TOPageTitleAlignAverage:
            default:
                [hVisualFormat insertString:@"H:|" atIndex:0];
                [hVisualFormat appendString:@"|"];
                break;
        }
        
        
        [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hVisualFormat options:0 metrics:nil views:views]];
        
    }
}


- (void)updateIndicator{
    if (!self.indicatorView.superview) {
        [self.titleContentView insertSubview:self.indicatorView atIndex:0];
        
        //V:[indicatorView(height)]-bottomOffset-|
        NSString *vfl = [NSString stringWithFormat:@"V:[indicatorView(%f)]-%f-|",self.indicatorHeight - self.indicatorEdgeInsets.top - self.indicatorEdgeInsets.bottom,self.indicatorEdgeInsets.bottom];
        [self.titleContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:nil views:@{@"indicatorView":self.indicatorView}]];
    }else{
        [AutoLayoutHelper updateConstraints:self.indicatorView attribute:NSLayoutAttributeHeight constant:self.indicatorHeight - self.indicatorEdgeInsets.top - self.indicatorEdgeInsets.bottom];
        [AutoLayoutHelper updateConstraints:self.indicatorView attribute:NSLayoutAttributeBottom constant:self.indicatorEdgeInsets.bottom];
    }
    
    
    //config indicatorView
    if (self.selectedIndex != -1) {
        TOPageTitleButton *button = [_buttons objectAtIndex:self.selectedIndex];
        if (button) {
            [self.titleContentView removeConstraints:[AutoLayoutHelper constraintsWithPaddingLeftRight:self.indicatorView]];
            [self.titleContentView addConstraints:[AutoLayoutHelper createConstaints:self.indicatorView paddingLeft:button.buttonLeftView leftOffset:self.indicatorEdgeInsets.left paddingRight:button.buttonRightView rightOffset:-self.indicatorEdgeInsets.right]];
            self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
            
        }else{
            self.indicatorView.translatesAutoresizingMaskIntoConstraints = YES;
        }
    }else{
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = YES;
    }
    
}

- (TOPageTitleButton *)factoryCreateButton:(TOPageItem *)item{
    TOPageTitleButton *button = [[TOPageTitleButton alloc] init];
    [button setTitleColor:self.titleColor forState:UIControlStateNormal];
    [button setTitleColor:self.highlightedTitleColor forState:UIControlStateHighlighted];
    [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
    
    [button.titleLabel setFont:self.textFont];
    
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitle:item.highlightedTitle forState:UIControlStateSelected];
    
    if ([item.icon isKindOfClass:[UIImage class]]) {
        [button setImage:(UIImage *)item.icon forState:UIControlStateNormal];
    }else if ([item.icon isKindOfClass:[NSString class]]) {
        SEL sel = NSSelectorFromString(@"sd_setImageWithURL: forState:");
        if ([button respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [button performSelector:sel withObject:item.icon withObject:@(UIControlStateNormal)];
#pragma clang diagnostic pop
        }
    }
    
    if ([item.highlightedIcon isKindOfClass:[UIImage class]]) {
        [button setImage:(UIImage *)item.highlightedIcon forState:UIControlStateSelected];
    }else if ([item.highlightedIcon isKindOfClass:[NSString class]]) {
        SEL sel = NSSelectorFromString(@"sd_setImageWithURL: forState:");
        if ([button respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [button performSelector:sel withObject:item.highlightedIcon withObject:@(UIControlStateSelected)];
#pragma clang diagnostic pop
        }
    }
    
    [button addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.titleViewDelegate respondsToSelector:@selector(pageTitleView:willShowButton:forItem:)]) {
        [self.titleViewDelegate pageTitleView:self willShowButton:button forItem:item];
    }
    
    return button;
}

#pragma mark - Events
- (void)buttonClickHandler:(TOPageTitleButton *)button{
    NSInteger newIndex = button.buttonIndex;
    if ([self shouldSelectItemAtIndex:newIndex]) {
        NSInteger oldIndex = self.selectedIndex;
        if ([self.titleViewDelegate respondsToSelector:@selector(pageTitleView:willSelecteIndex:oldIndex:)]) {
            [self.titleViewDelegate pageTitleView:self willSelecteIndex:self.selectedIndex oldIndex:oldIndex];
        }
        self.selectedIndex = newIndex;
        if ([self.titleViewDelegate respondsToSelector:@selector(pageTitleView:didSelecteIndex:oldIndex:)]) {
            [self.titleViewDelegate pageTitleView:self didSelecteIndex:self.selectedIndex oldIndex:oldIndex];
        }
    }
}

- (BOOL)shouldSelectItemAtIndex:(NSInteger)index{
    TOPageItem *item = [self.titles objectAtIndex:index];
    if (item && item.clickHandler) {
        return item.clickHandler();
    }else if ([self.titleViewDelegate respondsToSelector:@selector(pageTitleView:shouldSelectedIndex:)]) {
        return [self.titleViewDelegate pageTitleView:self shouldSelectedIndex:index];
    }
    return YES;
}

#pragma mark - Public
- (void)setNeedsUpdateButtons{
    _needsUpdateButtons = YES;
    [self setNeedsUpdateConstraints];
}
- (void)setNeedsUpdateIndicator{
    _needsUpdateIndicator = YES;
    [self setNeedsUpdateConstraints];
}

@end
