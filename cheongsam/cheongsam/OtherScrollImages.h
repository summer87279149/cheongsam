//
//  OtherScrollImages.h
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
//项目修改后此类名未改，该类实际是首页UICollectionView section＝1的headerView
@interface OtherScrollImages : UICollectionReusableView
@property(nonatomic,copy)NSMutableArray *NetImageArray;

@property(nonatomic,strong)SDCycleScrollView* WYNetScrollView;
@end
