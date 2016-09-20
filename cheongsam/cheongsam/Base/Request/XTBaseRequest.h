//
//  XTBaseRequest.h
//  XTCommon
//
//  Created by Admin on 16/9/20.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XTBaseRequestReponseDelegate <NSObject>
@required
/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;
@end

typedef void(^XTAPIDicCompletion)(id response, BOOL success, NSString *message);

@interface XTBaseRequest : NSObject

@property (nonatomic, weak) id <XTBaseRequestReponseDelegate> xt_delegate;
/** 链接*/
@property (nonatomic, copy) NSString *xt_url;
/** 默认GET*/
@property (nonatomic, assign) BOOL xt_isPost;
/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*xt_imageArray;

/** 构造方法*/
+ (instancetype)xt_request;
+ (instancetype)xt_requestWithUrl:(NSString *)xt_url;
+ (instancetype)xt_requestWithUrl:(NSString *)xt_url isPost:(BOOL)xt_isPost;
+ (instancetype)xt_requestWithUrl:(NSString *)xt_url isPost:(BOOL)xt_isPost delegate:(id <XTBaseRequestReponseDelegate>)xt_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)xt_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)xt_sendRequestWithCompletion:(XTAPIDicCompletion)completion;

@end
