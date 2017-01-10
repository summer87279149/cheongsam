//
//  CompanyViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/27.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "CompanyViewController.h"
#import "HMSegmentedControl.h"
NSInteger const kTopViewHeight = 150;
NSInteger const iconWidthOrHeight = 100;
NSInteger const padding = 10;
NSInteger const vipIconWidth = 120;
NSInteger const vipIconHeight = 22;
NSInteger const segmentedControlHeight = 30;
@interface CompanyViewController ()

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UIImageView *vipIcon;

@property(nonatomic,strong)UILabel *CompanyName;

@property(nonatomic,strong)HMSegmentedControl *segmentedControl;

@property(nonatomic,strong)UITextView *CompanyInfotextView;

@property(nonatomic,strong)UITableView *productsTableView;

@property(nonatomic,strong)UITableView*connectsTableView;


@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self createProductsTableView];
    [self createConnectsTableView];
}
-(void)createTopView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight)];
    _topView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    _icon = [[UIImageView alloc]init];
    [_topView addSubview:_icon];
    _icon.frame = CGRectMake(padding,padding, iconWidthOrHeight, iconWidthOrHeight);
    _icon.centerY = _topView.centerY;
    
    _CompanyName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+padding, CGRectGetMinY(_icon.frame), kScreenWidth-iconWidthOrHeight, iconWidthOrHeight/2)];
    [_topView addSubview:_CompanyName];

    _vipIcon =[[UIImageView alloc]init];
    [_topView addSubview:_vipIcon];
    _vipIcon.frame = CGRectMake(CGRectGetMaxX(_icon.frame)+padding,CGRectGetMaxY(_CompanyName.frame), vipIconWidth, vipIconHeight);
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"简介", @"产品", @"联系"]];
    _segmentedControl.selectionStyle=HMSegmentedControlSelectionStyleBox;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    [self.view addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(padding);
        make.top.mas_equalTo(_topView.mas_bottom).offset(padding);
        make.width.mas_equalTo(kScreenWidth-2*padding);
        make.height.mas_equalTo(segmentedControlHeight);
    }];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];

}


-(void)createProductsTableView{
    self.CompanyInfotextView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentedControl.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_segmentedControl.frame))];
    [self.view addSubview:self.CompanyInfotextView];
}

-(void)createConnectsTableView{
    
    
    
}

-(void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl{
    
    
    
    
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
