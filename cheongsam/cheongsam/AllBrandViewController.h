//
//  AllBrandViewController.h
//  cheongsam
//
//  Created by Admin on 16/9/26.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CheongsamBrand){
    CheongsamBrandAll,
    CheongsamBrandRecommand,
    CheongsamBrandDomestic,
    CheongsamBrandInternational,
};

@interface AllBrandViewController : UIViewController

@property (nonatomic,assign)CheongsamBrand cheongsamBrandType;

- (instancetype)initWithType:(CheongsamBrand)CheongsamBrandType;
@end
