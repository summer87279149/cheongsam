//
//  QPHModel.m
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "QPHModel.h"

@implementation QPHModel
-(instancetype)initWith:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        self.image = dic[@"images"];
        self.title = dic[@"prodname"];
        self.BrandId = dic[@"id"];
    }
    return self;
}
@end
