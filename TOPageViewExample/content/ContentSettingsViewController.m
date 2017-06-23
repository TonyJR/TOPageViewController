//
//  ContentSettingsViewController.m
//  TOPageView
//
//  Created by Tony on 17/6/21.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "ContentSettingsViewController.h"
#import "TOPageTitleView.h"

@interface ContentSettingsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TOPageTitleView *titleView;
@property (nonatomic,strong) NSMutableArray<TOPageItem *> *titles;

@end

@implementation ContentSettingsViewController

#pragma mark - Life Cycle
- (instancetype)init{
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑菜单";
    
    //config titleView
    self.titleView.titles = self.titles;
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.titleView];
    
    //config tableView
    self.tableView.frame = CGRectMake(0, self.titleView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.titleView.frame.size.height);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier1"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier2"];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Events
- (void)edit:(UINavigationItem *)item{
    self.tableView.editing = !self.tableView.editing;
    if (self.tableView.editing) {
        item.title = @"完成";
    }else{
        item.title = @"删除";
    }
    [self.tableView reloadData];
}

#pragma mark - Getter
- (TOPageTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[TOPageTitleView alloc] init];
        _titleView.miniGap = 10;
    }
    return _titleView;
}

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
                                                   [TOPageItem itemWithTitle:@"测试一下"],
                                                   ]];
    }
    return _titles;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titles.count;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier1" forIndexPath:indexPath];
        cell.textLabel.text = self.titles[indexPath.row].title;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier2" forIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"添加新数据";
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        return YES;
    }else{
        return NO;
    }
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.titles removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    self.titleView.titles = self.titles;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        [self.titles addObject: [TOPageItem itemWithTitle:@"新增数据"]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.titles.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        self.titleView.titles = self.titles;
    }else{
        self.titleView.selectedIndex = indexPath.row;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /** 不同的行, 可以设置不同的编辑样式, 编辑样式是一个枚举类型 */
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
