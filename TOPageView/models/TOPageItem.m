//
//  TOPageItem.m
//  TOPageView
//
//  Created by Tony on 17/6/20.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TOPageItem.h"

@implementation TOPageItem


+ (instancetype)itemWithTitle:(NSString *)title{
    return [[self alloc] initWithTitle:title highlightedTitle:nil icon:nil highlightedIcon:nil viewController:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(id)icon{
    return [[self alloc] initWithTitle:title highlightedTitle:nil icon:icon highlightedIcon:nil viewController:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle{
    return [[self alloc] initWithTitle:title highlightedTitle:highlightedTitle icon:nil highlightedIcon:nil viewController:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle icon:(id)icon highlightedIcon:(id)highlightedIcon{
    return [[self alloc] initWithTitle:title highlightedTitle:highlightedTitle icon:icon highlightedIcon:highlightedIcon viewController:nil];
}

+ (instancetype)itemWithViewController:(UIViewController *)viewController{
    return [[self alloc] initWithTitle:nil highlightedTitle:nil icon:nil highlightedIcon:nil viewController:viewController];
}

+ (instancetype)itemWithTitle:(NSString *)title viewController:(UIViewController *)viewController{
    return [[self alloc] initWithTitle:title highlightedTitle:nil icon:nil highlightedIcon:nil viewController:viewController];
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(id)icon viewController:(UIViewController *)viewController{
    return [[self alloc] initWithTitle:title highlightedTitle:nil icon:icon highlightedIcon:nil viewController:viewController];

}

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle viewController:(UIViewController *)viewController{
    return [[self alloc] initWithTitle:title highlightedTitle:highlightedTitle icon:nil highlightedIcon:nil viewController:viewController];
}

+ (instancetype)itemWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle icon:(id)icon highlightedIcon:(id)highlightedIcon viewController:(UIViewController *)viewController{
    return [[self alloc] initWithTitle:title highlightedTitle:highlightedTitle icon:icon highlightedIcon:highlightedIcon viewController:viewController];
}

- (id)initWithTitle:(NSString *)title highlightedTitle:(NSString *)highlightedTitle icon:(id)icon highlightedIcon:(id)highlightedIcon viewController:(UIViewController *)viewController{

    if (self = [self init]) {
        self.title = title;
        self.highlightedTitle = highlightedTitle;
        self.icon = icon;
        self.highlightedIcon = highlightedIcon;
        self.viewController = viewController;
    }
    return self;
}

- (NSString *)title{
    if (!_title) {
        return self.viewController.title;
    }
    return _title;
}



@end
