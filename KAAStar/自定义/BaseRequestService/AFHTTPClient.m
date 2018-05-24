//
//  AFHTTPClient.m
//  KAAStar
//
//  Created by Clover on 2018/5/17.
//  Copyright © 2018年 yuandaiyong. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

@interface AFHTTPClient()

@property (nonatomic,strong) AFHTTPSessionManager       *manager;

@end

static AFHTTPClient *client = nil;

@implementation AFHTTPClient

+ (AFHTTPClient *)shareClient {
    if(!client) {
        client = [[AFHTTPClient alloc] init];
    }
    return client;
}

- (id)init {
    self = [super init];
    if(self) {
        self.manager = [AFHTTPSessionManager manager];
        // 2.申明返回的结果是text/html类型
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 10;
    }
    return self;
}


@end
