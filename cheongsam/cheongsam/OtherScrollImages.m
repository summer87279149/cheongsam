//
//  OtherScrollImages.m
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "OtherScrollImages.h"
@interface OtherScrollImages ()<WYScrollViewNetDelegate>

@end
@implementation OtherScrollImages
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _NetImageArray = [[NSMutableArray alloc]initWithCapacity:0];
        // ========测试数据 记得删掉=======
        _NetImageArray = [NSMutableArray arrayWithObjects:
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                         nil];
        _WYscrollview = [[WYScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) WithNetImages:_NetImageArray];
        /** 设置滚动延时*/
        _WYscrollview.AutoScrollDelay = 3;
        /** 设置占位图*/
        _WYscrollview.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
        /** 获取网络图片的index*/
        self.WYscrollview.netDelagate = self;
        /** 添加到当前View上*/
        [self addSubview:_WYscrollview];
    }
    return self;
}




@end
