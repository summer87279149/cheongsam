//
//  TopScrollImagesView.m
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//
#import "FourBtns.h"
#import "TopScrollImagesView.h"
@interface TopScrollImagesView ()<SDCycleScrollViewDelegate>

@end

@implementation TopScrollImagesView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _NetImageArray = [[NSMutableArray alloc]initWithCapacity:0];
        // ========测试数据 记得删掉=======
        _NetImageArray = [NSMutableArray arrayWithObjects:
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                         nil];
        CGRect re = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 200);
        _WYNetScrollView = [SDCycleScrollView cycleScrollViewWithFrame:re imageNamesGroup:_NetImageArray];
        /** 设置占位图*/
//        _WYNetScrollView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
        /** 获取网络图片的index*/
        self.WYNetScrollView.delegate = self;
        /** 添加到当前View上*/
        [self addSubview:_WYNetScrollView];
        
        
        for (int i = 0; i<4; ++i) {
            CGRect rect = CGRectMake(i*kScreenWidth/4, 210, kScreenWidth/4, 80);
            NSString *ImaName = [NSString stringWithFormat:@"%d",i];
            NSArray * titles = @[@"中国旗袍",@"秀场",@"品牌馆",@"旗袍会"];
            FourBtns *btn = [[FourBtns alloc]initWithFrame:rect andImage:[UIImage imageNamed:ImaName] andTitle:titles[i]];
            btn.tag = 100+i;
            [btn addTarget:self.delegate action:@selector(FourBtnClickedAt:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        
    }
    return self;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:index] forKey:@"index"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectImageAtIndex" object:nil userInfo:dic];
   
}

@end
