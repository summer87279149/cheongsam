//
//  XTBaseRequest.m
//  XTCommon
//
//  Created by Admin on 16/9/20.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "XTBaseRequest.h"
#import "NHRequestManager.h"

@implementation XTBaseRequest

#pragma mark - 构造
+ (instancetype)xt_request {
    return [[self alloc] init];
}

+ (instancetype)xt_requestWithUrl:(NSString *)xt_url {
    return [self xt_requestWithUrl:xt_url isPost:NO];
}

+ (instancetype)xt_requestWithUrl:(NSString *)xt_url isPost:(BOOL)xt_isPost {
    return [self xt_requestWithUrl:xt_url isPost:xt_isPost delegate:nil];
}

+ (instancetype)xt_requestWithUrl:(NSString *)xt_url isPost:(BOOL)xt_isPost delegate:(id <XTBaseRequestReponseDelegate>)xt_delegate {
    XTBaseRequest *request = [self xt_request];
    request.xt_url = xt_url;
    request.xt_isPost = xt_isPost;
    request.xt_delegate = xt_delegate;
    return request;
}

#pragma mark - 发送请求
- (void)xt_sendRequest {
    [self xt_sendRequestWithCompletion:nil];
}

- (void)xt_sendRequestWithCompletion:(XTAPIDicCompletion)completion {
    
    // 链接
    NSString *urlStr = self.xt_url;
    if (urlStr.length == 0) return ;
    
    // 参数
    NSDictionary *params = [self params];
    
    // 普通POST请求
    if (self.xt_isPost) {
        if (self.xt_imageArray.count == 0) {
            // 开始请求
            [NHRequestManager POST:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:XTResponseSeializerTypeJSON success:^(id responseObject) {
                
                // 处理数据
                [self handleResponse:responseObject completion:completion];
            } failure:^(NSError *error) {
                // 数据请求失败，暂时不做处理
            }];
        }
        
    } else { // 普通GET请求
        // 开始请求
        [NHRequestManager GET:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:XTResponseSeializerTypeJSON success:^(id responseObject) {
            
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSError *error) {
            // 数据请求失败，暂时不做处理
        }];
    }
    
//    // 上传图片
//    if (self.xt_imageArray.count) {
//        [NHRequestManager POST:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:NHResponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            NSInteger imgCount = 0;
//            for (UIImage *image in self.xt_imageArray) {
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
//                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
//                //                [NSString stringWithFormat:@"uploadFile%@",@(imgCount)]
//                [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:fileName mimeType:@"image/png"];
//                imgCount++;
//            }
//        } success:^(id responseObject) {
//            // 处理数据
//            [self handleResponse:responseObject completion:completion];
//        } failure:^(NSError *error) {
//            // 数据请求失败，暂时不做处理
//        }];
//    }
}

- (void)handleResponse:(id)responseObject completion:(XTAPIDicCompletion)completion {
    // 接口约定，如果message为retry即重试
    if ([responseObject[@"message"] isEqualToString:@"retry"]) {
        [self xt_sendRequestWithCompletion:completion];
        return  ;
    }
    
    // 数据请求成功回调
    BOOL success = [responseObject[@"message"] isEqualToString:@"success"];
    if (completion) {
        completion(responseObject[@"data"], success, @"");
    } else if (self.xt_delegate) {
        if ([self.xt_delegate respondsToSelector:@selector(requestSuccessReponse:response:message:)]) {
            [self.xt_delegate requestSuccessReponse:success response:responseObject[@"data"] message:@""];
        }
    }
    // 请求成功，发布通知
    [NSNotificationCenter postNotification:kNHRequestSuccessNotification];
}

// 设置链接
- (void)setxt_url:(NSString *)xt_url {
    if (xt_url.length == 0 || [xt_url isKindOfClass:[NSNull class]]) {
        return ;
    }
    _xt_url = xt_url;
}
- (NSDictionary *)params {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    return params;
}

@end
