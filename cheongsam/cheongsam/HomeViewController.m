//
//  HomeViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/13.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "BuyViewController.h"
#import "CompanyViewController.h"
#import "QiPaoHuiViewController.h"
#import "ChinaQPTableViewController.h"
#import "HomeCollectionViewCell.h"
#import "OtherScrollImages.h"
#import "HomeViewController.h"
#import "TopScrollImagesView.h"
#import "ShowViewController.h"
#import "BrandViewController.h"
#import "AllViewController.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BtnClickedDelegate>

@property(nonatomic,strong) TopScrollImagesView *topImagesView;

@property(nonatomic,strong) OtherScrollImages *otherImgaesView;


@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _otherImgaesView = [[OtherScrollImages alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [self createCollectionView];
    [self creatRefresh];
}

#pragma mark 4个按钮
-(void)FourBtnClickedAt:(UIButton *)sender{
    
    switch (sender.tag)
    {
        case 100:
        {
            ChinaQPTableViewController *a = [[ChinaQPTableViewController alloc]init];
             a.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        case 101:
        {
            AllViewController *a = [[AllViewController alloc]init];
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        case 102:
        {
            BrandViewController *a = [[BrandViewController alloc]init];
            a.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        case 103:
        {
            QiPaoHuiViewController *a = [[QiPaoHuiViewController alloc]init];
            a.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma  mark lazy

-(TopScrollImagesView *)topImagesView{
    if (!_topImagesView) {
        // 头视图创建在 MallViewController.m 中
        _topImagesView = [[TopScrollImagesView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _topImagesView.delegate = self;
    }
    return _topImagesView;
}


-(OtherScrollImages *)otherImgaesView{
    if (!_otherImgaesView) {
        _otherImgaesView = [[OtherScrollImages alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    }
    return _otherImgaesView;
}


#pragma mark 下拉刷新

-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"下拉刷新");
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
}


-(void)createCollectionView{
    
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44)collectionViewLayout:layout];
//        _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
        [_collectionView registerClass:[self.topImagesView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
    
        [_collectionView registerClass:[self.otherImgaesView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherView"];
    
//    [_collectionView registerClass:[self.otherScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherScrollView"];
 
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
    
}
#pragma mark delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    cell.Image.image = [UIImage imageNamed:@"测试图片"];
    cell.title.text = @"商家名或商品名";
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return CGSizeMake(kScreenWidth/2-10, kScreenWidth/2-10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 330);
    }else if(section == 1){
        return CGSizeMake(kScreenWidth, 200);
    }
    return CGSizeMake(kScreenWidth, 30);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader && 0 == indexPath.section ){
            self.topImagesView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView" forIndexPath:indexPath];
            reusableview = self.topImagesView;
     
    }else if(kind == UICollectionElementKindSectionHeader && 1 == indexPath.section){
//        self.otherScrollView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherScrollView" forIndexPath:indexPath];
//        reusableview = _otherScrollView;
            self.otherImgaesView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherView" forIndexPath:indexPath];
            reusableview = self.otherImgaesView;
        
    }else{
        
    }
    return reusableview;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CompanyViewController * vc =[[CompanyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        BuyViewController *vc = [[BuyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark ==============================

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"selectImageAtIndex" object:nil];
}

-(void)receiveNotification:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    NSNumber *number = dic[@"index"];
    NSInteger index = [number integerValue];
    NSLog(@"tongzhishi :%ld",(long)index);
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectImageAtIndex" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
