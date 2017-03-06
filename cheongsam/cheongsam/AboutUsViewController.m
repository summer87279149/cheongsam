//
//  AboutUsViewController.m
//  cheongsam
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (strong, nonatomic)  JHUD *hudView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self showJHUD];
    //隐藏 
//    [_hudView hide];
}
-(void)showJHUD{
    self.hudView = [[JHUD alloc]initWithFrame:self.view.bounds];
    _hudView.indicatorViewSize = CGSizeMake(100, 100);
    _hudView.messageLabel.text = @"Can't get data, please make sure the interface is correct !";
    _hudView.customImage = [UIImage imageNamed:@"null"];
    [_hudView showAtView:self.view hudType:JHUDLoadingTypeFailure];
//    [_hudView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.and.centerY.equalTo(self.view);
//        make.size.equalTo(self.view);
//    }];
}
-(void)hideJHUD{
    [_hudView hide];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
