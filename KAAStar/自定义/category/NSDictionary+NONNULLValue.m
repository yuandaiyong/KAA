//
//  NSDictionary+NONValue.m
//  Hospital_Patient
//
//  Created by yuandaiyong on 2018/1/23.
//  Copyright © 2018年 Clover. All rights reserved.
//

#import "NSDictionary+NONNULLValue.h"

@implementation NSDictionary (NONNULLValue)

- (NSString *)stringWithKey:(NSString *)key {
    
    NSString *str = @"";
    if([self.allKeys containsObject:key]) {
        id value = [self valueForKey:key];
        if(![value isEqual:[NSNull null]]) {
            str = [NSString stringWithFormat:@"%@",value];
            if([[str lowercaseString] isEqualToString:@"<null>"]) {
                str = @"";
            }
        }
    }
    return str;
}

- (NSArray *)arrayWithKey:(NSString *)key {
    NSArray *array = nil;
    if([self.allKeys containsObject:key]) {
        id value = [self valueForKey:key];
        if(![value isEqual:[NSNull null]]) {
            if([value isKindOfClass:[NSArray class]]) {
                array = (NSArray *)value;
            }
        }
    }
    return array;
}

- (NSDictionary *)dictionaryWithKey:(NSString *)key {
    NSDictionary *dict = nil;
    if([self.allKeys containsObject:key]) {
        id value = [self valueForKey:key];
        if(![value isEqual:[NSNull null]]) {
            if([value isKindOfClass:[NSDictionary class]]) {
                dict = (NSDictionary *)value;
            }
        }
    }
    return dict;
}
@end
