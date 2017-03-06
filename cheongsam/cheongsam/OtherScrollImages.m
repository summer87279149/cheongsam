//
//  OtherScrollImages.m
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "OtherScrollImages.h"
@interface OtherScrollImages ()<SDCycleScrollViewDelegate>

@end
@implementation OtherScrollImages
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
        CGRect re = CGRectMake(0, 25, kScreenWidth, 200);
//        _WYNetScrollView = [SDCycleScrollView cycleScrollViewWithFrame:re imageNamesGroup:_NetImageArray];
        _WYNetScrollView = [SDCycleScrollView cycleScrollViewWithFrame:re imageURLStringsGroup:_NetImageArray];
        /** 设置占位图*/
//        _WYNetScrollView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
        /** 获取网络图片的index*/
        self.WYNetScrollView.delegate = self;
        /** 添加到当前View上*/
        [self addSubview:_WYNetScrollView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth, 30)];
        label.text = @"推荐商品";
        [self addSubview:label];
        

    }
    return self;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:index] forKey:@"index"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectImageAtIndex" object:nil userInfo:dic];
    
}


@end
