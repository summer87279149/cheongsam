//
//  XTBaseImageView.h
//  XTCommon
//
//  Created by Admin on 16/9/19.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <YYImage/YYImage.h>
#import "YYAnimatedImageView.h"
@interface XTBaseImageView : YYAnimatedImageView
/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url;

- (void)setImageWithURL:(NSURL *)URL;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image;

- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;
@end
