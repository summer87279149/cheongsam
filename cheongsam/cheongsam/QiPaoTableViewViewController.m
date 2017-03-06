//
//  QiPaoTableViewViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "QPHModel.h"
#import "QiPaoTableViewViewController.h"
#import "TableViewCell.h"
@interface QiPaoTableViewViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *cellArr;
}
@property (nonatomic,strong)UITableView *tableview;
@end

@implementation QiPaoTableViewViewController

- (instancetype)initWithType:(BandAddress)addressType
{
    self = [super init];
    if (self) {
        self.addressType = addressType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"旗袍会";
    [self requestData];
    cellArr = [NSMutableArray array];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-100) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;
    
}

-(void)requestData{
    switch (self.addressType) {
            
        case BandAddressAll:{
            [RequestManager testRequest:^(id response) {
                NSLog(@"打印网络请求 %@",response);
                NSArray *arr = response[@"product"];
                for (NSDictionary *dic in arr) {
                    QPHModel *model = [[QPHModel alloc]initWith:dic];
                    [cellArr addObject:model];
                }
                [_tableview reloadData];
            } failure:^(id error) {
                
            }];
        }
            break;
        case BandAddressBeijing:{
            
        }
            break;
        case BandAddressShanghai:{
            
        }
            break;
        case BandAddressGuangzhou:{
            
        }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return cellArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = cellArr[indexPath.row];
    cell.title.text  = @"左边是公司logo，这里文字是公司名称";
    return cell;

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
    NSString *text = @"此处还没有旗袍会入驻哦";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//为自定义UIView
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
//}



- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
    NSLog(@"点击了空数据");
}


#pragma mark ------
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
