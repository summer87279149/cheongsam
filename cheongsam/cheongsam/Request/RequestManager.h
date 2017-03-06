//
//  RequestManager.h
//  cheongsam
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void(^Success)(id response);
typedef  void(^Error) (id error);

@interface RequestManager : NSObject

+(void)testRequest:(Success)success failure:(Error)Error;
    


@end
