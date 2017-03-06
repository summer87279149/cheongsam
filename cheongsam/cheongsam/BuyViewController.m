//
//  BuyViewController.m
//  cheongsam
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "BuyViewController.h"
#import "SDCycleScrollView.h"
#import "DetailViewController.h"
#import "CompanyViewController.h"
@interface BuyViewController ()

@property (nonatomic, copy) NSMutableArray *imagesArr;
@property(nonatomic,strong)SDCycleScrollView* imagesScrollView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, strong) UIButton *addToCarBtn;
@property (nonatomic, strong) NSMutableArray *bottomBtnsArr;
//@property (nonatomic, strong) UIButton *phoneBtn;
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
   _imagesArr = [NSMutableArray arrayWithObjects:
     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
     nil];
    [self.view addSubview:self.imagesScrollView];
    [self setupUI];
    [self setupTestData];
}

-(void)setupTestData{
    _nameLab.text = @"商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称，商品名称";
    _priceLab.text = [NSString stringWithFormat:@"¥%@",@"999.99"];
}

-(void)setupUI{
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.priceLab];
    [self.view addSubview:self.buyBtn];
    [self.view addSubview:self.addToCarBtn];
    for (int i = 0; i<self.bottomBtnsArr.count; ++i) {
        UIButton * btn = self.bottomBtnsArr[i];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/self.bottomBtnsArr.count);
            make.bottom.equalTo(self.view);
            make.left.mas_equalTo(kScreenWidth/self.bottomBtnsArr.count*i);
            make.height.mas_equalTo(50);
        }];
    }
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesScrollView.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.mas_bottom).offset(30);
        make.width.mas_equalTo(kScreenWidth/2-40);
        make.left.equalTo(self.view).offset(20);
        make.height.mas_equalTo(40);
    }];
    [_addToCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.mas_bottom).offset(30);
        make.width.mas_equalTo(kScreenWidth/2-40);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    
}

-(void)addToCarBtnClicked{
//    [MBProgressHUD showSuccess:@"已添加到购物车"];
    [Common showHUDWith:@"已添加到购物车" to:self.view];
}

-(void)buyBtnClicked{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提交成功" message:@"订单提交成功，稍后服务人员会电话联系您" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)bottomBtnClicked:(UIButton*)btn{
    switch (btn.tag) {
        case 100:{
            CompanyViewController *vc = [[CompanyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 101:{
            DetailViewController*detail = [[DetailViewController alloc]init];
            detail.detailLabel.text = @"我是旗袍详细信息，我是旗袍详细信息，我是旗袍详细信息，我是旗袍详细信息，我是旗袍详细信息，我是旗袍详细信息，";
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
            //share
        case 102:{
            [self sharBtnClicked];
        }
            break;
            //phone
        case 103:{
            NSString *phoneNum = @"4006767235";// 电话号码
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
            UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
            [self.view addSubview:phoneCallWebView];
        }
            break;
        default:
            NSLog(@"未处理的btn");
            break;
    }
}
#pragma  mark - ========友盟=======
//点击分享按钮
- (void)sharBtnClicked{
    __weak typeof(self) weakSelf = self;
    //    显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        NSLog(@"信息是userInfo:%@,platformType:%ld",userInfo,(long)platformType);
        [weakSelf runShareWithType:platformType];
    }];
    
}
- (void)runShareWithType:(UMSocialPlatformType)type
{
    [self shareTextToPlatformType:type];
}
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"欢迎使用中国旗袍";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"分享失败, error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"确定", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - lazyLoad
-(NSMutableArray*)bottomBtnsArr{
    if (!_bottomBtnsArr) {
        _bottomBtnsArr = [NSMutableArray array];
        NSArray *titleArr = @[@"进入店铺",@"详情",@"分享",@"电话"];
        for (int i = 0; i<titleArr.count; ++i) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i == 0) {
                [btn setBackgroundColor:[UIColor blackColor]];
            }else{
            [btn setBackgroundColor:[UIColor getColor:@"fc1ebb"]];
            }
            btn.tag = i+100;
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.showsTouchWhenHighlighted = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomBtnsArr addObject:btn];
        }
    }
    return _bottomBtnsArr;
}
-(UILabel*)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.numberOfLines = 2;
    }
    return _nameLab;
}
-(UILabel*)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.numberOfLines = 1;
        _priceLab.textColor = [UIColor redColor];
    }
    return _priceLab;
}
-(UIButton*)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setBackgroundColor:[UIColor getColor:@"fc6555"]];
        [_buyBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor getColor:@"fc6555"] forState:UIControlStateHighlighted];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buyBtn addTarget:self action:@selector(addToCarBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
         return _buyBtn;
}
         
-(UIButton *)addToCarBtn{
    if (!_addToCarBtn) {
        _addToCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToCarBtn setBackgroundColor:[UIColor getColor:@"fc6555"]];
        [_addToCarBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
        [_addToCarBtn setTitleColor:[UIColor getColor:@"fc6555"] forState:UIControlStateHighlighted];
        [_addToCarBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _addToCarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _addToCarBtn;
}
         

-(SDCycleScrollView*)imagesScrollView{
    if (!_imagesScrollView) {
        _imagesScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageURLStringsGroup:_imagesArr];
    }
    return _imagesScrollView;
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
