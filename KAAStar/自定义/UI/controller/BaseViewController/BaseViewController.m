//
//  BaseViewController.m
//  TianFuQXiPhone
//
//  Created by Clover on 2017/11/13.
//  Copyright © 2017年 Clover. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(245, 248, 251);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createContent {
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.clipsToBounds = YES;
    [self.view addSubview:self.contentView];
}

- (void)createTitle:(NSString *)title leftBtnHide:(BOOL)hide mode:(TF_TitleMode)model{
    
    self.titleView = [[TF_TitleView alloc] initWithTitle:title leftBtnHide:hide];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.titleView.leftBtn addTarget:self action:@selector(clickLeftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.titleView];
    if(model == TF_TitleModePush) {
        self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.titleView.frame));
    }

}

- (UIButton *)addRightButton:(UIImage *)image title:(NSString *)title {
    CGFloat y = 20;
    if(ISIPHONEX){
        y += 15;
    }
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - TITLE_BUTTON_WIDTH - 5, y + (TITLE_HEIGHT - TITLE_BUTTON_WIDTH - y) / 2, TITLE_BUTTON_WIDTH, TITLE_BUTTON_WIDTH)];
    if(image){
        [rightBtn setImage:image forState:UIControlStateNormal];
    }else{
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightBtn setTitle:title forState:UIControlStateNormal];
    }
    [self.titleView addSubview:rightBtn];
    return rightBtn;
}

- (void)clickLeftButtonAction {
    
    if(self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
