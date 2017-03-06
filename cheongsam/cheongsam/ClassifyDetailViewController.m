//
//  ClassifyDetailViewController.m
//  cheongsam
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "SerachResultTableViewController.h"
#import "ClassifyDetailCell.h"
#import "ClassifyDetailViewController.h"
#import "HMSegmentedControl.h"
@interface ClassifyDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic,strong)HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,copy)NSMutableArray *cellArr;

@property (nonatomic, strong) SerachResultTableViewController *searchResultVC;

@end

@implementation ClassifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

-(UISearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, 40)];
        _searchBar.placeholder = @"请输入旗袍名称";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

-(void)setupUI{
    self.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"最新", @"销量", @"价格",@"人气"]];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.selectionStyle=HMSegmentedControlSelectionStyleBox;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.top.mas_equalTo(self.searchBar.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth-2*10);
        make.height.mas_equalTo(30);
    }];
    __weak typeof(self) weakSelf = self;
    _segmentedControl.indexChangeBlock = ^(NSInteger index){
        [_searchBar resignFirstResponder];
        switch (index) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            default:
                break;
        }
    };
   
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDCell"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text.length>0) {
        NSLog(@"可以搜索");
        SerachResultTableViewController *vc = [[SerachResultTableViewController alloc]init];
        vc.searchKeyword = searchBar.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    NSLog(@"不可以搜索");
}

-(UITableView*)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, kScreenHeight-90-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.hidden = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"ClassifyDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"IDCell"];
        [_tableView setTableHeaderView:self.searchController.searchBar];
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension ;
        self.definesPresentationContext = YES;
        
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            SHOWHUD
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"下拉刷新");
                [weakSelf.tableView.mj_header endRefreshing];
                HIDEHUD
            });
        }];
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            SHOWHUD
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"上拉刷新");
                HIDEHUD
                [weakSelf.tableView.mj_header endRefreshing];
            });
        }];
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}
#pragma mark - DZNEmptyDataSetSource



-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"没有数据哦";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"啊哦，没有数据，请重试";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
#pragma mark - Getter
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultVC];
        [_searchController.searchBar setPlaceholder:@"请输入旗袍名字"];
        [_searchController.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [_searchController.searchBar sizeToFit];
        [_searchController setSearchResultsUpdater:self.searchResultVC];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    }
    return _searchController;
}

- (SerachResultTableViewController *) searchResultVC
{
    if (_searchResultVC == nil) {
        _searchResultVC = [[SerachResultTableViewController alloc] init];
        _searchResultVC.cellArray = self.cellArr;
//        _searchResultVC.searchResultDelegate = self;
    }
    return _searchResultVC;
}

-(NSMutableArray*)cellArr{
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
