//
//  NSString+CGSize.m
//  KAAStar
//
//  Created by Clover on 2018/5/17.
//  Copyright © 2018年 yuandaiyong. All rights reserved.
//

#import "NSString+CGSize.h"

@implementation NSString (CGSize)

- (CGSize)stringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    
    NSDictionary * attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}
@end
