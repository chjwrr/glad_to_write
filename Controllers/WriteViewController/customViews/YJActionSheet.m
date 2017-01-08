//
//  YJActionSheet.m
//  yueJi
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJActionSheet.h"

#define ksubViewHeight     40

@interface YJActionSheet (){
    NSInteger count;
}



@end

@implementation YJActionSheet


- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle destructiveButtonTitle:(NSString *)destructiveTitle otherButtonTitles:(NSArray *)btns {
    self=[super init];
    if (self) {
        
        [self initSubButtonWithTitle:title cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveTitle otherButtonTitles:btns];
        
    }
    return self;
}

- (void)initSubView {
    
}


- (void)initSubButtonWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle destructiveButtonTitle:(NSString *)destructiveTitle otherButtonTitles:(NSArray *)btns  {
    
    count=[btns count];
    
    self.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, ksubViewHeight+ksubViewHeight+ksubViewHeight+ksubViewHeight*[btns count]+10);
   
    self.backgroundColor=kColorHexString(kuserThemeBgColor);
    
    
    YJThemeButton *btn_title=[[YJThemeButton alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, ksubViewHeight)];
    [self addSubview:btn_title];
    btn_title.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
    [btn_title setTitle:title forState:UIControlStateNormal];
    [btn_title setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn_des=[[UIButton alloc]initWithFrame:CGRectMake(0, btn_title.y+btn_title.height, kSCREEN_WIDTH, ksubViewHeight)];
    [self addSubview:btn_des];
    [btn_des setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn_des.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 17);
    [btn_des setTitle:destructiveTitle forState:UIControlStateNormal];
    [btn_des setBackgroundColor:[UIColor whiteColor]];
    [btn_des addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [btn_des addTarget:self action:@selector(touchDownUpSide:) forControlEvents:UIControlEventTouchUpInside];
    [btn_des addTarget:self action:@selector(touchDownOutSide:) forControlEvents:UIControlEventTouchDragOutside];
    btn_des.tag=100;
    
    CGFloat otherHeight=ksubViewHeight*[btns count];
    
    for (int i=0; i<[btns count]; i++) {
        YJThemeButton *btn_other=[[YJThemeButton alloc]initWithFrame:CGRectMake(0, btn_des.y+btn_des.height+ksubViewHeight*i, kSCREEN_WIDTH, ksubViewHeight)];
        [self addSubview:btn_other];
        btn_other.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 17);
        [btn_other setTitle:[btns objectAtIndex:i] forState:UIControlStateNormal];
        [btn_other setBackgroundColor:[UIColor whiteColor]];
        [btn_other addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [btn_other addTarget:self action:@selector(touchDownUpSide:) forControlEvents:UIControlEventTouchUpInside];
        [btn_other addTarget:self action:@selector(touchDownOutSide:) forControlEvents:UIControlEventTouchDragOutside];
        btn_other.tag=101+i;

    }
    
    YJThemeButton *btn_cancel=[[YJThemeButton alloc]initWithFrame:CGRectMake(0, btn_des.y+btn_des.height+otherHeight+10, kSCREEN_WIDTH, ksubViewHeight)];
    [self addSubview:btn_cancel];
    btn_cancel.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 17);
    [btn_cancel setTitle:cancelTitle forState:UIControlStateNormal];
    [btn_cancel setBackgroundColor:[UIColor whiteColor]];
    [btn_cancel addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [btn_cancel addTarget:self action:@selector(touchDownUpSide:) forControlEvents:UIControlEventTouchUpInside];
    [btn_cancel addTarget:self action:@selector(touchDownOutSide:) forControlEvents:UIControlEventTouchDragOutside];
    btn_cancel.tag=100+count+1;
    
}


- (void)showInView:(UIView *)supView {
    
    [supView addSubview:self];
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.frame=CGRectMake(0, kSCREEN_HEIGHT-(ksubViewHeight+ksubViewHeight+ksubViewHeight+ksubViewHeight*count-10)-20, kSCREEN_WIDTH, ksubViewHeight+ksubViewHeight+ksubViewHeight+ksubViewHeight*count+10);

    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)hiddent {
    [UIView animateWithDuration:0.15 animations:^{
        
        self.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, ksubViewHeight+ksubViewHeight+ksubViewHeight+ksubViewHeight*count+10);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];

}
//按钮点击
- (void)touchDown:(YJThemeButton *)button {
    [button setBackgroundColor:kColorHexString(@"E8E8E8")];
}

//按钮拖拽到外部
- (void)touchDownOutSide:(YJThemeButton *)button {
    [button setBackgroundColor:[UIColor whiteColor]];
}

//按钮点击事件
- (void)touchDownUpSide:(YJThemeButton *)button {
    
    [button setBackgroundColor:[UIColor whiteColor]];
    
    [self.delegate YJActionSheet:self clickedButtonAtIndex:button.tag-100];

    [self hiddent];
    
}



@end
