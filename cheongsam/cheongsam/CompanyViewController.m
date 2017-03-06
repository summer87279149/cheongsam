//
//  CompanyViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/27.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "BuyViewController.h"
#import "RETableViewManager.h"
#import <RETableViewManager/RETableViewManager.h>
#import "RETableViewOptionsController.h"
#import "CompanyViewController.h"
#import "HMSegmentedControl.h"
NSInteger const kTopViewHeight = 150;
NSInteger const iconWidthOrHeight = 100;
NSInteger const padding = 10;
NSInteger const vipIconWidth = 120;
NSInteger const vipIconHeight = 22;
NSInteger const segmentedControlHeight = 30;
@interface CompanyViewController ()<UITableViewDelegate,UITableViewDataSource,RETableViewManagerDelegate>

@property (nonatomic, strong) RETableViewManager *manager;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UIImageView *vipIcon;

@property(nonatomic,strong)UILabel *CompanyName;

@property(nonatomic,strong)HMSegmentedControl *segmentedControl;

@property(nonatomic,strong)UITextView *CompanyInfotextView;

@property(nonatomic,strong)UITableView *productsTableView;

@property(nonatomic,strong)UITableView*connectsTableView;

@property(nonatomic,copy)NSMutableArray *cellArr;
@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    [self createTopView];
    [self createCompanyInfotextView];
    [self createProductsTableView];
    [self createConnectsTableView];
    [self setupTestData];
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
    _segmentedControl.selectedSegmentIndex = 0;
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
    __weak typeof(self) weakSelf = self;
    _segmentedControl.indexChangeBlock = ^(NSInteger index){
        NSLog(@"打印index:%ld",index);
        switch (index) {
            case 0:
                weakSelf.CompanyInfotextView.hidden = NO;
                weakSelf.productsTableView.hidden = YES;
                weakSelf.connectsTableView.hidden = YES;
                break;
            case 1:
                weakSelf.CompanyInfotextView.hidden = YES;
                weakSelf.productsTableView.hidden = NO;
                 weakSelf.connectsTableView.hidden = YES;
                break;
            case 2:
                weakSelf.productsTableView.hidden = YES;
                 weakSelf.CompanyInfotextView.hidden = YES;
                 weakSelf.connectsTableView.hidden = NO;
                break;
            default:
                break;
        }
    };
}

-(void)createCompanyInfotextView{
    self.CompanyInfotextView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentedControl.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_segmentedControl.frame))];
        [self.view addSubview:self.CompanyInfotextView];
    [self.CompanyInfotextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
-(void)createProductsTableView{
    [self.view addSubview: self.productsTableView];
    [self.productsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    

}
-(void)createConnectsTableView{
    [self.view addSubview: self.connectsTableView];
    
    [self.connectsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    //1 初始化manmager
    self.manager = [[RETableViewManager alloc] initWithTableView:self.connectsTableView];
    //2 添加一个section
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"联系信息"];
    [self.manager addSection:section];
    // Add a string
    [section addItem:@"企业名称"];
    [section addItem:@"联系人:张三"];
    [section addItem:[RETableViewItem itemWithTitle:@"联系电话:43432423432" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        NSString *phoneNum = @"43432423432";// 电话号码
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
        UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];   [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
        [self.view addSubview:phoneCallWebView];
    }]];
    // Add a basic cell with disclosure indicator
    [section addItem:[RETableViewItem itemWithTitle:@"企业网址www.baidu.com" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    }]];
}

-(void)setupTestData{
    _icon.image = [UIImage imageNamed:@"1"];
    _CompanyName.text = @"企业名称:亮点网络";
    self.CompanyInfotextView.text = @"企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。企业介绍。。";
}

-(void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl{
    
    
    
    
}
-(UITableView*)connectsTableView{
    if (!_connectsTableView) {
        _connectsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentedControl.frame), kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _connectsTableView.delegate = self;
        _connectsTableView.dataSource = self;
        _connectsTableView.tableFooterView = [UIView new];
        _connectsTableView.hidden = YES;
    }
    return _connectsTableView;
}
-(UITableView*)productsTableView{
    if (!_productsTableView) {
        _productsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentedControl.frame), kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _productsTableView.delegate = self;
        _productsTableView.dataSource = self;
        _productsTableView.tableFooterView = [UIView new];
        _productsTableView.hidden = YES;
    }
    return _productsTableView;
}

-(NSMutableArray*)cellArr{
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    //从缓冲池里面取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //判断缓冲池是否有需要的cell
    if(cell==nil){
        //如果缓冲池中没有cel，重新创建
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.imageView.image = [UIImage imageNamed:@"测试图片"];
    cell.textLabel.text = @"旗袍名称";
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyViewController *vc = [[BuyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
