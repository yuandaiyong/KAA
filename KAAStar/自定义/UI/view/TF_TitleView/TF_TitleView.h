//
//  TF_TitleView.h
//  TianFuQXiPhone
//
//  Created by Clover on 2017/11/13.
//  Copyright © 2017年 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TITLE_BUTTON_WIDTH                  40

@interface TF_TitleView : UIView

@property (nonatomic,copy) NSString             *title;
@property (nonatomic,strong) UIButton           *leftBtn;

- (id)initWithTitle:(NSString *)title leftBtnHide:(BOOL)hide;

@end
