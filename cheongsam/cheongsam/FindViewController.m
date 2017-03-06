//
//  FindViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/13.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "CenterIdentifyViewController.h"
#import "BeforeScanSingleton.h"
#import "AboutUsViewController.h"
#import "FeedbackViewController.h"
#import "NewsTableViewController.h"
#import "FindViewController.h"
#import "FindCollectionViewCell.h"
@interface FindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *cellArr;
}
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    cellArr = @[@"新闻中心",
                @"关于我们",
                @"联系我们",
                @"在线反馈",
                @"二维码扫描",
                @"中心认证",
                ];
    [self createCollectionView];
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
    [_collectionView registerNib:[UINib nibWithNibName:@"FindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    
}



#pragma mark delegate and datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.icon.image = [UIImage imageNamed:@"FindImage"];
    cell.title.text = cellArr[indexPath.row];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cellArr.count;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth/3, 100);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            NewsTableViewController *vc = [[NewsTableViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            AboutUsViewController* vc = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            NSString *phoneNum = @"11111111";// 电话号码
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
            UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];   [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
            [self.view addSubview:phoneCallWebView];
        }
            break;
        case 3:{
            FeedbackViewController *vc = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController: vc animated:YES];
        }
            break;
        case 4:{
            [[BeforeScanSingleton shareScan] ShowSelectedType:AliPayStyle WithViewController:self];
        }
            break;
        case 5:{
            CenterIdentifyViewController *vc = [[CenterIdentifyViewController alloc]init];
            [self.navigationController pushViewController: vc animated:YES];
        }
            break;
        default:
            break;
    }
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
