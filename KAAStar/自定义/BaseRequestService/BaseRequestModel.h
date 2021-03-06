//
//  BaseRequestService.h
//  TianFuQXiPhone
//
//  Created by Clover on 2017/11/14.
//  Copyright © 2017年 Clover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONModel.h"
@interface BaseRequestModel : JSONModel


/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)post:(NSString *)url success:(void (^)(NSString *responseStr))success failure:(void (^)(NSString *result,NSString *alertMsg))failure;

/**
 *  上传图片
 */
- (void)postImage:(UIImage *)image name:(NSString *)name  url:(NSString *)url success:(void (^)(NSString *responseStr))success failure:(void (^)(NSString *result,NSString *alertMsg))failure;

@end
