//
//  YJPasswordView.m
//  yueJi
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJPasswordView.h"


#define kviewHeihgt    50.0f

@interface YJPasswordView ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,assign)BOOL isWrite;

@property (nonatomic,strong)NSString *str_first_psd;
@property (nonatomic,strong)NSString *str_second_psd;

@property (nonatomic,strong)UILabel *lab_show;

@end
@implementation YJPasswordView

+ (instancetype)shareInstance {
    static YJPasswordView *view=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        view=[[YJPasswordView alloc]init];
    });
    return view;
}

- (void)showIsWritePsd:(BOOL)isWrite {
    self.isWrite=isWrite;
    self.str_first_psd=@"";
    self.textField.text=@"";
    self.lab_show.text=@"";
    
    self.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        if (finished) {
            
            [self.textField becomeFirstResponder];
        }
    }];
    
}

- (void)hiddent {
    if (self.y == kSCREEN_HEIGHT) {
        return;
    }
    
    [self.textField becomeFirstResponder];

    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}
- (void)initSubView  {
    _str_first_psd=[[NSString alloc]init];
    
    self.backgroundColor=kColorHexString(kuserThemeBgColor);
    
    self.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddentKeyBoard:)];
    [self addGestureRecognizer:tap];

    [self addSubview:self.bgView];
    
    [self addSubview:self.textField];

    [self addSubview:self.lab_show];
}

- (UITextField *)textField {
    if (!_textField) {
        
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(self.bgView.x+kviewHeihgt/2-5, 50, kSCREEN_WIDTH, self.bgView.height)];
        [self addSubview:_textField];
        _textField.keyboardType=UIKeyboardTypeNumberPad;
        _textField.secureTextEntry=YES;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-kviewHeihgt*6)/2, 50, kviewHeihgt*6, kviewHeihgt)];
        _bgView.backgroundColor=[UIColor whiteColor];
        _bgView.layer.borderWidth=1;
        _bgView.layer.borderColor=kColorHexString(kuserThemeFontColor).CGColor;
        
        
        for (int i=0; i<5; i++) {
            UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(_bgView.width/6*(i+1), 0, 1, kviewHeihgt)];
            [_bgView addSubview:line];
            line.backgroundColor=kColorHexString(kuserThemeFontColor);
        }
        
    }
    return _bgView;
}

- (UILabel *)lab_show {
    if (!_lab_show) {
        _lab_show=[[UILabel alloc]initWithFrame:CGRectMake(0, self.textField.y+self.textField.height+10, kSCREEN_WIDTH, 20)];
        _lab_show.textAlignment=NSTextAlignmentCenter;
        _lab_show.textColor=kColorHexString(kuserThemeFontColor);
        _lab_show.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
    }
    return _lab_show;
}


- (void) textFieldDidChange:(UITextField *)textField{
    NSLog(@"textField.text  %@",textField.text);
    
    NSDictionary *attrsDictionary =@{NSFontAttributeName: self.textField.font,NSKernAttributeName:[NSNumber numberWithFloat:40]};//这里修改字符间距
    
    self.textField.attributedText=[[NSAttributedString alloc]initWithString:textField.text attributes:attrsDictionary];

    if (textField.text.length >=6) {
        self.textField.text=[self.textField.text substringToIndex:6];
        
        //输入密码
        if (self.isWrite) {
            
             //第一次输入密码
            if ([self.str_first_psd isEmpty]) {
               
                //保存第一次输入的密码
                self.str_first_psd=self.textField.text;
                
                //继续重新输入
                self.textField.text=@"";
                NSLog(@"第一次设置密码成功");
                self.lab_show.text=@"请再次输入密码";
                
            }else{
                //和第一次比较，
                if ([self.textField.text isEqualToString:self.str_first_psd]) {
                    //一样，密码设置成功
                    NSLog(@"第二次设置密码成功");
                    self.lab_show.text=@"密码设置成功";
                    
                    ksetDefaultValueForKey(self.textField.text, kuserPassword);
                    ksetDefaultValueForKey(@"1", kuserOpenPassword);
                    
                    [self hiddent];
                    
                }else{
                    //不一样.重新输入
                    self.textField.text=@"";
                    NSLog(@"第二次设置密码和第一次不一样，重新设置");
                    self.lab_show.text=@"密码输入错误，请重新输入";

                }
            }
            
            
            
        }else{
            //验证密码
            if ([self.textField.text isEqualToString:kFormatterSring(kgetDefaultValueForKey(kuserPassword))]) {
                //验证成功，进入主程序
                self.lab_show.text=@"密码验证成功";

                [self hiddent];

            }else{
                //验证失败，继续验证
                self.textField.text=@"";
                self.lab_show.text=@"密码验证失败，请重新输入";

            }
            
            
        }
        
       
    }
    
}


- (void)hiddentKeyBoard:(UITapGestureRecognizer *)tap {
    [self.textField resignFirstResponder];
}
















@end
