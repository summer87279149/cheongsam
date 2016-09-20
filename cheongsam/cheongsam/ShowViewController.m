
//
//  ShowViewController.m
//  cheongsam
//
//  Created by Admin on 16/9/20.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "ShowViewController.h"
#import "AllViewController.h"
@interface ShowViewController ()<WMPageControllerDelegate,WMMenuViewDataSource>

@end

@implementation ShowViewController

- (void)viewDidLoad {
    self.title = @"秀场";
    self.menuHeight = 44; //导航栏高度
    self.menuItemWidth = 100; //每个 MenuItem 的宽度
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;//这里设置菜单view的样式
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
    self.progressColor = [UIColor redColor];//设置下划线(或者边框)颜色
    self.titleSizeSelected = 18;//设置选中文字大小
    self.titleColorSelected = [UIColor redColor];//设置选中文字颜色
    self.titleSizeNormal = 14;
    self.selectIndex = 1;
    [super viewDidLoad];//这里注意，需要写在最后面，要不然上面的效果不会出现
}


//设置viewcontroller的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}


//设置对应的viewcontroller
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        return [[AllViewController alloc ]init];
    }else {
        return [[AllViewController alloc ]init];
    }
    
}


//设置每个viewcontroller的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    if (index == 0) {
        return @"全部";
    }
    return @"买家秀";
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
