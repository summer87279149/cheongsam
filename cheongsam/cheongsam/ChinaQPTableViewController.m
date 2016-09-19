//
//  ChinaQPTableViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/18.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "ChinaQPTableViewController.h"
#import "ChinaQpTableViewCell.h"
@interface ChinaQPTableViewController ()

@end

@implementation ChinaQPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"中国旗袍";
    
  }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OrderCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([ChinaQpTableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    ChinaQpTableViewCell *cell = (ChinaQpTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.title.text = @"1月23日，电影电视剧《穿旗袍的女人》远远海选云南分赛区决出12强";
    cell.time.text = @"2016-01-29";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"暂无网页,请制作网页";
    [hud hideAnimated:YES afterDelay:1];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
