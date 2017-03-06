//
//  AllBrandViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "AllBrandViewController.h"
#import "ShowCollectionViewCell.h"
@interface AllBrandViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *cellArr;
}
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation AllBrandViewController

- (instancetype)initWithType:(CheongsamBrand)CheongsamBrandType
{
    self = [super init];
    if (self) {
        self.cheongsamBrandType = CheongsamBrandType;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    [self createCollectionView];
    [self creatRefresh];
}

-(void)requestData{
    switch (self.cheongsamBrandType) {
            
        case CheongsamBrandAll:{
            [RequestManager testRequest:^(id response) {
                NSLog(@"打印网络请求 %@",response);
            } failure:^(id error) {
                
            }];
        }
            break;
        case CheongsamBrandRecommand:{
            
        }
            break;
        case CheongsamBrandDomestic:{
            
        }
            break;
        case CheongsamBrandInternational:{
            
        }
            break;
    }
}

-(void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44)collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"ShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    
    _collectionView.emptyDataSetSource = self;
    _collectionView.emptyDataSetDelegate = self;
    
}
-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"下拉刷新");
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
}

#pragma mark delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.Image.image = [UIImage imageNamed:@"测试图片"];
    cell.title.text = @"推荐旗袍青玉案1111111";
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth/2-5, kScreenWidth/2);
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
    NSString *text = @"此处还没有品牌馆入驻哦";
    
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











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
