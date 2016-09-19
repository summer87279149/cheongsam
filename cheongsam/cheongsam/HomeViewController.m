//
//  HomeViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/13.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "ChinaQPTableViewController.h"
#import "MJRefresh.h"
#import "HomeCollectionViewCell.h"
#import "OtherScrollImages.h"
#import "HomeViewController.h"
#import "TopScrollImagesView.h"
#import "lastScrollImages.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BtnClickedDelegate>

@property(nonatomic,strong) TopScrollImagesView *topImagesView;

@property(nonatomic,strong) OtherScrollImages *otherImgaesView;

@property(nonatomic,strong) lastScrollImages *lastImages;

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
            UIViewController *a = [[UIViewController alloc]init];
            a.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        case 102:
        {
            UIViewController *a = [[UIViewController alloc]init];
            a.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:a animated:YES];
        }
            break;
        case 103:
        {
            UIViewController *a = [[UIViewController alloc]init];
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


-(lastScrollImages *)lastImages{
    if (!_lastImages) {
        _lastImages = [[lastScrollImages alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        
    }
    return _lastImages;
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
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
        [_collectionView registerClass:[self.topImagesView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
    
        [_collectionView registerClass:[self.otherImgaesView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherView"];
    
        [_collectionView registerClass:[self.lastImages class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lastView"];
    
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
    
}
#pragma mark delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    cell.Image.image = [UIImage imageNamed:@"测试图片"];
    cell.title.text = @"推荐旗袍\n青玉案";
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return CGSizeMake(kScreenWidth/2, kScreenWidth/2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 290);
    }
    return CGSizeMake(kScreenWidth, 200);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader && 0 == indexPath.section ){
        
            self.topImagesView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView" forIndexPath:indexPath];
            reusableview = self.topImagesView;
     
    }else if(kind == UICollectionElementKindSectionHeader && 1 == indexPath.section){
            self.otherImgaesView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"otherView" forIndexPath:indexPath];
            reusableview = _otherImgaesView;
    }else{
            self.lastImages = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"lastView" forIndexPath:indexPath];
            reusableview = _lastImages;
    }
    return reusableview;
}



#pragma mark ==============================

-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden = YES;
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
    // Dispose of any resources that can be recreated.
}



@end
