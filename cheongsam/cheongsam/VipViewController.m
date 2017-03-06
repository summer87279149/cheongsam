//
//  VipViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/13.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "OrderTableViewController.h"
#import "CommodityCollectTableViewController.h"
#import "ShopCollectTableViewController.h"
#import "VipViewController.h"
#import "OtherTableViewCell.h"
#import "TopTableViewCell.h"
@interface VipViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableview;
@end

@implementation VipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableview];
}
-(void)createTableview{
    self.tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    self.tableview.delegate=self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
//    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([TopTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"topCell"];
//    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([OtherTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"otherCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 150;
    }
    return 70;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row==0) {
        static NSString *CellIdentifier = @"topCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([TopTableViewCell class]) bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
            nibsRegistered = YES;
        }
        TopTableViewCell *cell = (TopTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"otherCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([OtherTableViewCell class]) bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
            nibsRegistered = YES;
        }
        OtherTableViewCell *cell = (OtherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 1) {
            cell.label.text = @"购物车";
        }else if (indexPath.row == 2){
            cell.label.text = @"我的订单";
        }else if (indexPath.row == 3){
            cell.label.text = @"店铺收藏";
        }else if (indexPath.row == 4){
            cell.label.text = @"商品收藏";
        }
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
           
            
        }
            break;
        case 3:
        {
           
            ShopCollectTableViewController*vc = [[ShopCollectTableViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            CommodityCollectTableViewController *vc= [[CommodityCollectTableViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
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
