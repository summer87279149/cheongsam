//
//  ShopViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/13.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "CompanyViewController.h"
#import "ShopViewController.h"
#import "ShopTableViewCell.h"
#import "BuyViewController.h"
@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商铺";
    [self setUpNav];
    [self creatRefresh];
}

-(UITableView*)tableview{
    if (!_tableview) {
        CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
        _tableview = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        [self.view addSubview:_tableview];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
    }
    return _tableview;
}
-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"下拉刷新");
            [weakSelf.tableview.mj_header endRefreshing];
        });
    }];
}
#pragma mark- dalegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([ShopTableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    ShopTableViewCell *cell = (ShopTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shopImageTapDelegate = [RACSubject subject];
    @weakify(self);
    [cell.shopImageTapDelegate subscribeNext:^(id x) {
        @strongify(self);
        CompanyViewController *vc = [[CompanyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    cell.QPimageViewDelegate = [RACSubject subject];
    [cell.QPimageViewDelegate subscribeNext:^(id x) {
        @strongify(self);
        BuyViewController *vc= [[BuyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
    
}





#pragma mark-navigation backBtn
- (void)setUpNav
{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_back_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}


- (void)pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

@end
