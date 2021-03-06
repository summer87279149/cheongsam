//
//  AllViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/20.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "AllViewController.h"
#import "ShowCollectionViewCell.h"
#import "WebViewController.h"
@interface AllViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"秀场";
    [self createCollectionView];
    [self creatRefresh];
}

-(void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"ShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.Image.image = [UIImage imageNamed:@"测试图片"];
    cell.title.text = @"推荐旗袍青玉案";
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth/2-10, kScreenWidth/2-10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [Common showHUDWith:@"暂无网页，请制作网页" to:self.view];
    WebViewController *webVC = [[WebViewController alloc]initWithUrlString:@"http://www.baidu.com"];
    [self.navigationController pushViewController:webVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
