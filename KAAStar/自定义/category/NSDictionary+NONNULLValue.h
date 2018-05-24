//
//  NSDictionary+NONValue.h
//  Hospital_Patient
//
//  Created by yuandaiyong on 2018/1/23.
//  Copyright © 2018年 Clover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NONULLValue)

- (NSString *)stringWithKey:(NSString *)key;

- (NSArray *)arrayWithKey:(NSString *)key;

- (NSDictionary *)dictionaryWithKey:(NSString *)key;

@end
