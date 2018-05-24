//
//  TF_TitleView.m
//  TianFuQXiPhone
//
//  Created by Clover on 2017/11/13.
//  Copyright © 2017年 Clover. All rights reserved.
//

#import "TF_TitleView.h"

@interface TF_TitleView()

@property (nonatomic,strong) UILabel            *titleLabel;

@end

@implementation TF_TitleView

- (id)initWithTitle:(NSString *)title leftBtnHide:(BOOL)hide {
    
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, TITLE_HEIGHT);
        CGFloat y = 20;
        if(ISIPHONEX) {
            y = 15 + 20;
        }
        if(hide) {
            self.titleLabel.frame = CGRectMake(5, y, SCREEN_WIDTH - 10, TITLE_HEIGHT - y);
        }else {
            self.titleLabel.frame = CGRectMake(TITLE_BUTTON_WIDTH + 5, y, SCREEN_WIDTH - (TITLE_BUTTON_WIDTH + 5) * 2, TITLE_HEIGHT - y);
        }
        self.titleLabel.text = title;
        
        if(!hide) {
            self.leftBtn.frame = CGRectMake(5, y + (TITLE_HEIGHT - y - TITLE_BUTTON_WIDTH) / 2, TITLE_BUTTON_WIDTH, TITLE_BUTTON_WIDTH);
        }
    }
    return self;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)leftBtn {
    if(!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setImage:[UIImage imageNamed:@"title_back"] forState:UIControlStateNormal];
        _leftBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
