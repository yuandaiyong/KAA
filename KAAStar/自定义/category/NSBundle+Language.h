//
//  NSBundle+Language.h
//  LocalDemo
//
//  Created by Clover on 2018/5/17.
//  Copyright © 2018年 yuandaiyong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BundleEX : NSBundle

@end


@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

@end
