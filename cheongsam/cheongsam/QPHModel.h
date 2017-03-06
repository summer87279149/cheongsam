//
//  QPHModel.h
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QPHModel : NSObject

@property (nonatomic, copy)  NSString *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *BrandId;

-(instancetype)initWith:(NSDictionary*)dic;

@end
