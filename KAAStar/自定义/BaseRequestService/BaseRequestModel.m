//
//  BaseRequestService.m
//  TianFuQXiPhone
//
//  Created by Clover on 2017/11/14.
//  Copyright © 2017年 Clover. All rights reserved.
//

#import "BaseRequestModel.h"

@implementation BaseRequestModel

- (id)init {
    self = [super init];
    if(self){
        self.device_code = [UIDevice Lx_deviceCode];
        self.apiv = [APPDefine getApiv];
        self.appv = [APPDefine getAppv];
        if([UserManager manager].loginedUser) {
            self.user_id = [UserManager manager].loginedUser.user_id;
        }
        NSDate *date = [NSDate date]; // 获得时间对象
        NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
        NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
        NSDate *nowDate = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
        self.time = [NSString stringWithFormat:@"%.0f",[nowDate timeIntervalSince1970]];
    }
    
    return self;
}
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //将token封装入请求头"
    [mgr.requestSerializer setValue:@"HYQX-APP" forHTTPHeaderField:@"device"];
    
    
    // 3.发送GET请求
    [mgr GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)post:(NSString *)url success:(void (^)(NSString *responseStr))success failure:(void (^)(NSString *result,NSString *alertMsg))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
//    [mgr.requestSerializer setValue:@"HYQX-APP" forHTTPHeaderField:@"device"];
    // 4.发送POST请求
    
    NSDictionary*paraDict = [NSDictionary dictionaryWithObject:[LxDES3Util encrypt:[self toJSONString]]  forKey:@"jsonParameter"];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@%@",R_HOST,R_PROJECT,R_VERSION,url,R_POSTFIX];
    
    [mgr POST:path parameters:paraDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *enStr= [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //3、解密NSString
        NSString *decryptStr = [LxDES3Util decrypt:enStr];
        NSDictionary *datas = [NSJSONSerialization JSONObjectWithData:[decryptStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSInteger status = [[datas objectForKey:@"status"] integerValue];
        if(status == 200) {
            NSDictionary *info = [datas objectForKey:@"datas"];
            if([info isEqual:[NSNull null]]) {
                if(failure){
                    failure(@"服务器返回<null>数据",@"服务器数据格式错误");
                }
            }else{
                NSData *data = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if (success) {
                    success(str);
                }
            }
        }else{
            NSString *result = [datas objectForKey:@"message"];
            NSString *alert = [datas objectForKey:@"message_alert"];
            if(failure) {
                failure(result,alert);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([error localizedDescription],@"请检查您的网络");
        }
    }];
}

/**
 *  上传图片
 */
- (void)postImage:(UIImage *)image name:(NSString *)name  url:(NSString *)url success:(void (^)(NSString *responseStr))success failure:(void (^)(NSString *result,NSString *alertMsg))failure {
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    //    [mgr.requestSerializer setValue:@"HYQX-APP" forHTTPHeaderField:@"device"];
    // 4.发送POST请求
    
    NSDictionary*paraDict = [NSDictionary dictionaryWithObject:[LxDES3Util encrypt:[self toJSONString]]  forKey:@"jsonParameter"];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@%@",R_HOST,R_PROJECT,R_VERSION,url,R_POSTFIX];
    [mgr POST:path parameters:paraDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.f);
        NSTimeInterval timeInterVal = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%.0f.jpg",timeInterVal];
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *enStr= [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //3、解密NSString
        NSString *decryptStr = [LxDES3Util decrypt:enStr];
        NSDictionary *datas = [NSJSONSerialization JSONObjectWithData:[decryptStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSInteger status = [[datas objectForKey:@"status"] integerValue];
        if(status == 200) {
            NSDictionary *info = [datas objectForKey:@"datas"];
            if([info isEqual:[NSNull null]]) {
                if(failure){
                    failure(@"服务器返回<null>数据",@"服务器数据格式错误");
                }
            }else{
                NSData *data = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if (success) {
                    success(str);
                }
            }
        }else{
            NSString *result = [datas objectForKey:@"message"];
            NSString *alert = [datas objectForKey:@"message_alert"];
            if(failure) {
                failure(result,alert);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure([error localizedDescription],@"请检查您的网络");
        }
    }];
}

@end
