//
//  BaseViewController.h
//  TianFuQXiPhone
//
//  Created by Clover on 2017/11/13.
//  Copyright © 2017年 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TF_TitleView.h"

typedef enum {
    TF_TitleModePush, //标题在顶部,内容下移
    TF_TitleModecover //标题覆盖在内容上面，内容不下移
}TF_TitleMode;
@interface BaseViewController : UIViewController

@property (nonatomic,strong) TF_TitleView        *titleView;
@property (nonatomic,strong) UIView               *contentView;

- (void)createTitle:(NSString *)title leftBtnHide:(BOOL)hide mode:(TF_TitleMode)model;

- (UIButton *)addRightButton:(UIImage *)image title:(NSString *)title ;

- (void)clickLeftButtonAction;

@end
