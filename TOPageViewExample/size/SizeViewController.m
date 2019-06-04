//
//  SizeViewController.m
//  TOPageView
//
//  Created by Tony on 17/6/22.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "SizeViewController.h"
#import "TOPageTitleView.h"

@interface SizeViewController ()

@property (nonatomic,strong) IBOutlet NSLayoutConstraint *titleWidthConstraint;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *titleHeightConstraint;
@property (nonatomic,strong) IBOutlet UITextField *edgeTop;
@property (nonatomic,strong) IBOutlet UITextField *edgeBottom;
@property (nonatomic,strong) IBOutlet UITextField *edgeLeft;
@property (nonatomic,strong) IBOutlet UITextField *edgeRight;


@property (nonatomic,strong) IBOutlet TOPageTitleView *titleView;
@property (nonatomic,strong) NSMutableArray<TOPageItem *> *titles;

@end

@implementation SizeViewController

#pragma mark - Life Cycle


- (instancetype)init{
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"尺寸设置";
    self.titleView.titles = self.titles;
    self.titleView.contentInsets = UIEdgeInsetsMake(0, -12, 0, 12);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Getter
- (NSMutableArray<TOPageItem *> *)titles{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:@[
                                                   [TOPageItem itemWithTitle:@"母婴"],
                                                   [TOPageItem itemWithTitle:@"美妆"],
                                                   [TOPageItem itemWithTitle:@"保健"],
                                                   [TOPageItem itemWithTitle:@"服饰"],
                                                   [TOPageItem itemWithTitle:@"食品"],
                                                   [TOPageItem itemWithTitle:@"百货"],
                                                   [TOPageItem itemWithTitle:@"数码"],
                                                   ({
            TOPageItem *pageItem = [TOPageItem itemWithTitle:@"数码"];
            pageItem.minWidth = 60;
            pageItem;
        }),
                                                   ]];
    }
    return _titles;
}


#pragma mark - Events
- (IBAction)widthChangeHandler:(UISlider *)widthSlider{
    self.titleWidthConstraint.constant = (widthSlider.value - 1) * self.view.frame.size.width;
}

- (IBAction)heightChangeHandler:(UISlider *)heightSlider{
    self.titleHeightConstraint.constant = heightSlider.value;
}

- (IBAction)indicatorChangeHandler:(UISlider *)heightSlider{
    self.titleView.indicatorHeight = heightSlider.value;
}

- (IBAction)updateEdge:(id)sender
{
    self.titleView.indicatorEdgeInsets = UIEdgeInsetsMake(
                                                          [self.edgeTop.text floatValue],
                                                          [self.edgeLeft.text floatValue],
                                                          [self.edgeBottom.text floatValue],
                                                          [self.edgeRight.text floatValue]);
    self.titleView.contentInsets = UIEdgeInsetsMake(
                                                    [self.edgeTop.text floatValue],
                                                    [self.edgeLeft.text floatValue],
                                                    [self.edgeBottom.text floatValue],
                                                    [self.edgeRight.text floatValue]);
}

- (IBAction)cornerRadiusChangeHandler:(UISwitch *)switchView{
    if (switchView.on) {
        self.titleView.indicatorView.layer.cornerRadius = 5;
    }else{
        self.titleView.indicatorView.layer.cornerRadius = 0;
    }
    self.titleView.indicatorView.clipsToBounds = YES;
}
@end

