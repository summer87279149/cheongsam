//
//  Common.h
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "JHUD.h"
@interface Common : NSObject
+(void)showHUDWith:(NSString *)message to:(UIView*)view;
@end
