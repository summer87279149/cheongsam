//
//  RequestManager.m
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "RequestManager.h"
#import "XTRequestManager.h"
@implementation RequestManager
+(void)testRequest:(Success)success failure:(Error)Error{
    [XTRequestManager GET:XTCommonAPIConstantShop parameters:nil responseSeializerType:NHResponseSeializerTypeJSON success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        Error(error);
    }];
}
@end
