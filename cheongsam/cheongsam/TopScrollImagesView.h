//
//  TopScrollImagesView.h
//  cheongsam
//
//  Created by Admin on 16/9/14.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"
@protocol BtnClickedDelegate <NSObject>


@end


@interface TopScrollImagesView : UICollectionReusableView

@property(nonatomic,copy)NSMutableArray *NetImageArray;

@property(nonatomic,strong)SDCycleScrollView* WYNetScrollView;

@property(nonatomic,weak) id <BtnClickedDelegate>delegate;
@end
