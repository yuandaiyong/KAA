//
//  NSString+CGSize.h
//  KAAStar
//
//  Created by Clover on 2018/5/17.
//  Copyright © 2018年 yuandaiyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CGSize)

- (CGSize)stringSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

@end
