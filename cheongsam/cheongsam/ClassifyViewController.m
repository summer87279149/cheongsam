//
//  ClassifyViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/13.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "ClassifyDetailViewController.h"
#import "CLassiFyCollectionViewCell.h"
#import "ClassifyViewController.h"
@interface ClassifyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    [self creatRefresh];
}
-(void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44)collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"CLassiFyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CLassiCell"];
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

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLassiFyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CLassiCell" forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:@"测试图片"];
    
    switch (indexPath.row) {
        case 0:
        cell.title.text = @"旗袍类别";
            break;
        case 1:
        cell.title.text = @"例如：";
            break;
        case 2:
       cell.title.text = @"古典旗袍";
            break;
        case 3:
          cell.title.text = @"现代旗袍";
            break;
        default:
            cell.title.text = @"⬆️上是类别图片";
            break;
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-40)/3, kScreenWidth/3);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyDetailViewController *vc = [[ClassifyDetailViewController alloc]init];
    vc.navTitle = @"分类详情";
    [self.navigationController pushViewController:vc animated:YES];
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
