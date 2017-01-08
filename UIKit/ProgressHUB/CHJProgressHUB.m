//
//  CHJProgressHUB.m
//  yueJi
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "CHJProgressHUB.h"

#define kiconWight     30
#define kspaceWidth    10

@interface CHJProgressHUB ()

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)YJThemeLabel *lab_message;
@property (nonatomic,strong)YJThemeLabel *lab_icon;


@end

@implementation CHJProgressHUB


+ (instancetype)shareInstance {
    static CHJProgressHUB *hub=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        hub=[[CHJProgressHUB alloc]init];
    });
    return hub;
}

- (void)initSubView {
    
    self.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);

    [self addSubview:self.bgView];
    
    [self.bgView addSubview:self.lab_icon];
    
    [self.bgView addSubview:self.lab_message];
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _bgView.center=self.center;
        _bgView.layer.masksToBounds=YES;
        _bgView.layer.cornerRadius=5;
        
        _bgView.layer.borderWidth=0.5;
    }
    _bgView.layer.borderColor=kColorHexString(kuserThemeFontColor).CGColor;
    _bgView.backgroundColor=kColorHexString(kuserThemeBgColor);
    
    return _bgView;
}

- (YJThemeLabel *)lab_icon {
    if (!_lab_icon) {
        _lab_icon=[[YJThemeLabel alloc]initWithFrame:CGRectMake(5, 5, kiconWight, kiconWight)];
        _lab_icon.text=@"悦";
        _lab_icon.textAlignment=NSTextAlignmentCenter;
    }
    _lab_icon.textColor=kColorHexString(kuserThemeFontColor);
    _lab_icon.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 30);
    return _lab_icon;
}

- (YJThemeLabel *)lab_message {
    if (!_lab_message) {
        _lab_message=[[YJThemeLabel alloc]initWithFrame:CGRectMake(50, 25, 50, 50)];
        _lab_message.numberOfLines=0;

    }
    _lab_message.textColor=kColorHexString(kuserThemeFontColor);
    _lab_message.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);

    return _lab_message;
}

- (void)showMessage:(NSString *)message {

    CGFloat width=[message boundingRectWithSize:CGSizeMake(2000, 20) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14)} context:nil].size.width+20;
    
    if (width > kSCREEN_WIDTH-kspaceWidth*2-kiconWight-kiconWight/2) {
        //需要多行显示
        CGFloat height=[message boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH-kspaceWidth*2-kiconWight-kiconWight/2, 2000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14)} context:nil].size.height+20;

        self.bgView.frame=CGRectMake(kspaceWidth, (kSCREEN_HEIGHT-(height+kiconWight+kiconWight/2))/2, kSCREEN_WIDTH-kspaceWidth*2, height+kiconWight+kiconWight/2);
        
        self.lab_message.frame=CGRectMake(kiconWight, kiconWight, kSCREEN_WIDTH-kspaceWidth*2-kiconWight-kiconWight/2, height);
        
    }else{
        //单行显示
        self.bgView.frame=CGRectMake((kSCREEN_WIDTH-(width+kiconWight+kiconWight/2))/2, (kSCREEN_HEIGHT-(20+kiconWight+kiconWight/2))/2, width+kiconWight+kiconWight/2, 20+kiconWight+kiconWight/2);
        
        self.lab_message.frame=CGRectMake(kiconWight, kiconWight, width, 20);

    }
    
    self.lab_message.text=message;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];

     self.bgView.layer.transform = CATransform3DMakeRotation(M_PI/2, 1, 0, 0);
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bgView.layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);

    } completion:^(BOOL finished) {
        
        if (finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self hiddent];
                
            });
        }
        
    }];
    
    
}

- (void)hiddent {

    [UIView animateWithDuration:0.25 animations:^{
        
        self.bgView.layer.transform = CATransform3DMakeRotation(M_PI/2, 1, 0, 0);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];

}


@end
