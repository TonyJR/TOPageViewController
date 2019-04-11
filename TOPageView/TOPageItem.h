//
//  TOPageItem.h
//  TOPageView
//
//  Created by Tony on 17/6/20.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TOPageItem : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *highlightedTitle;

//This param should be a UIImage object, if SDWebImage ( https://github.com/rs/SDWebImage ) in your project it's also can be a NSString object.
@property (nonatomic,strong) id icon;
@property (nonatomic,strong) id highlightedIcon;

@property (nonatomic,strong) UIViewController *viewController;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title icon:(id)icon;

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle;

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle icon:(id)icon highlightedIcon:(id)highlightedIcon;

+ (instancetype)itemWithViewController:(UIViewController *)viewController;

+ (instancetype)itemWithTitle:(NSString *)title viewController:(UIViewController *)viewController;

+ (instancetype)itemWithTitle:(NSString *)title icon:(id)icon viewController:(UIViewController *)viewController;

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle viewController:(UIViewController *)viewController;

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle icon:(id)icon highlightedIcon:(id)highlightedIcon viewController:(UIViewController *)viewController;

- (id)initWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle icon:(id)icon highlightedIcon:(id)highlightedIcon viewController:(UIViewController *)viewController;

@end
