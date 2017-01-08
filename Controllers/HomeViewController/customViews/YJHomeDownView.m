//
//  YJHomeDownView.m
//  yueJi
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJHomeDownView.h"

#define kviewShowHeight      100
#define kviewHiddentHeight   44

@interface YJHomeDownView ()

@property (nonatomic,strong) YJThemeButton *btn_right;
@property (nonatomic,assign) BOOL isShow;

@end
@implementation YJHomeDownView

- (void)initSubView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontColor:) name:kThemeColorChangeNotificationName object:nil];
    
    [self changeViewBgColor];
    
    YJThemeButton *button=[[YJThemeButton alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-44)/2, 0, 44, 44) imageName:@"YJHomeSendNote"];
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonSend) forControlEvents:UIControlEventTouchUpInside];
    
    _btn_right=[[YJThemeButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-44, 0, 44, 44) imageName:@"YJHomeMenu"];
    [self addSubview:_btn_right];
    [_btn_right addTarget:self action:@selector(buttonMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _isShow=NO;
    
    
    NSArray *images=@[@"YJHomeTheme",@"YJHomeFont",@"YJHomeSetting"];
    NSArray *titles=@[@"主题",@"显示",@"设置"];
    
    CGFloat space=(kSCREEN_WIDTH-44*3)/4;
    
    for (int i=0; i<3; i++) {
        YJThemeButton *button=[[YJThemeButton alloc]initWithFrame:CGRectMake(space+(space+44)*i, 44, 44, 50) imageName:[images objectAtIndex:i]];
        [self addSubview:button];
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font=kSYS_FONT(14);
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 7, 20, 7)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(30, -30, 0, 0)];
        button.tag=100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)reloadDownView {
    YJThemeButton *button1=(YJThemeButton *)[self viewWithTag:100];
    YJThemeButton *button2=(YJThemeButton *)[self viewWithTag:101];
    YJThemeButton *button3=(YJThemeButton *)[self viewWithTag:102];
    
    button1.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
    button2.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
    button3.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);

}


- (void)changeFontColor:(NSNotification *)tification {
    [self changeViewBgColor];
}

- (void)changeViewBgColor {
    self.backgroundColor=kColorHexString(kuserThemeBgColor);
}

/**
 *  发布事件
 */
- (void)buttonSend {
    if (self.delegate) {
        [self.delegate YJHomeDownViewDidSelectSend];
    }
}

/**
 *  菜单事件
 */
- (void)buttonMenu {
    
    if (self.delegate) {
        
        if (_isShow) {
            //隐藏
            [self hiddent];
        }else{
            //显示
            [self show];
        }
        _isShow=!_isShow;

        [self.delegate YJHomeDownViewShowState:_isShow];

    }
}

/**
 *  显示
 */
- (void)show {
    [UIView animateWithDuration:0.15 animations:^{
        self.frame=CGRectMake(0, kSCREEN_HEIGHT-kviewShowHeight, kSCREEN_WIDTH, kviewShowHeight);

        [_btn_right changeImageName:@"YJHomeCanelMenu"];
        
    } completion:^(BOOL finished) {
        if (finished) {
            _isShow=YES;
        }
    }];
}

/**
 *  隐藏
 */
- (void)hiddent {
    if (self.y == kSCREEN_HEIGHT-kviewHiddentHeight) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.frame=CGRectMake(0, kSCREEN_HEIGHT-kviewHiddentHeight, kSCREEN_WIDTH, kviewShowHeight);

        [_btn_right changeImageName:@"YJHomeMenu"];

    } completion:^(BOOL finished) {
        if (finished) {
            _isShow=NO;
        }
    }];

}

/**
 *  点击 主题、显示、设置 按钮
 *
 *  @param button 100.主题 101.显示 102.设置
 */
- (void)buttonAction:(YJThemeButton *)button {
    if (self.delegate) {
        [self.delegate YJHomeDownViewDidSelectIndex:button.tag];
    }
}

/**
 *  显示完全下的高度
 *
 *  @return 返回高度
 */
+ (CGFloat)viewShowHeight {
    return kviewShowHeight;
}

/**
 *  显示不完全的高度
 *
 *  @return 返回高度
 */
+ (CGFloat)viewHiddentwHeight {
    return kviewHiddentHeight;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
