//
//  TOPageViewController.m
//  TOPageView
//
//  Created by Tony on 17/6/19.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TOPageViewController.h"

#define TO_PAGE_TITLE_HEIGHT 46

@interface TOPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,TOPageTitleViewDelegate>
{
    UIPageViewController *_pageViewController;
    NSArray *_viewControllers;
    NSUInteger _willTransitionToIndex;
}

@property (nonatomic,strong) TOPageTitleView *titleView;

@end

@implementation TOPageViewController

- (void)loadView{
    [super loadView];
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, TO_PAGE_TITLE_HEIGHT);
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.titleView];
    
    
    self.pageViewController.view.frame = CGRectMake(0, TO_PAGE_TITLE_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TO_PAGE_TITLE_HEIGHT);
    self.pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pageViewController.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Getter
- (TOPageTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[TOPageTitleView alloc] init];
        _titleView.titleViewDelegate = self;
    }
    return _titleView;
}

- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
    return _pageViewController;
}

- (NSInteger)selectedIndex{
    return self.titleView.selectedIndex;
}



#pragma mark - Setter
- (void)setItemList:(NSArray<TOPageItem *> *)itemList{
    _itemList = itemList;
    self.titleView.titles = itemList;
    NSMutableArray *vcs = [NSMutableArray array];
    for (TOPageItem *item in itemList) {
        if (!item.viewController) {
            item.viewController = [[UIViewController alloc] init];
        }
        [vcs addObject:item.viewController];

    }
    _viewControllers = vcs;
    if (self.titleView.selectedItem){
        [self.pageViewController setViewControllers:@[self.titleView.selectedItem.viewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];

    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    NSInteger oldIndex = self.titleView.selectedIndex;
    self.titleView.selectedIndex = selectedIndex;
    [self pageTitleView:self.titleView didSelecteIndex:selectedIndex oldIndex:oldIndex];
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int index = (int)[_viewControllers indexOfObject:viewController];
    if (index==0) {
        return nil;
    }else{
        return _viewControllers[index-1];
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int index = (int)[_viewControllers indexOfObject:viewController];
    if (index>=_viewControllers.count-1) {
        return nil;
    }else{
        return _viewControllers[index+1];
    }
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

    if (completed) {
        self.titleView.selectedIndex = _willTransitionToIndex;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    _willTransitionToIndex = [_viewControllers indexOfObject:pendingViewControllers.firstObject];
}

#pragma mark - TOPageTitleViewDelegate
- (void)pageTitleView:(TOPageTitleView *)pageTitleView didSelecteIndex:(NSInteger)index oldIndex:(NSInteger)oldIndex{
    
    
    //  Now, tell the pageViewContoller to accept these guys and do the forward turn of the page.
    //  Again, forward is subjective - you could go backward.  Animation is optional but it's
    //  a nice effect for your audience.
    if (index >= _viewControllers.count) {
        index = _viewControllers.count - 1;
    }
    
    if (index >= 0) {
        self.pageViewController.view.hidden = NO;

        NSArray *viewControllers = @[ _viewControllers[index]];

        if (oldIndex == -1) {
            [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:NULL];
        }else if(index > oldIndex){
            [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];

        }else{
            [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];

        }
    }else{
        self.pageViewController.view.hidden = YES;
    }

}
@end
