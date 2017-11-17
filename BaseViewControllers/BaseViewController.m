//
//  BaseViewController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,strong)YJThemeLabel *lab_title;
@property (nonatomic,strong)YJThemeButton *btn_cancel;


@end
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontColor:) name:kThemeColorChangeNotificationName object:nil];

    
    [self changeViewBgColor];
    
    
    [self initDataSource];
    
    [self initSubViews];
    
}

- (void)changeFontColor:(NSNotification *)tification {
    [self changeViewBgColor];
}

- (void)changeViewBgColor {
    self.view.backgroundColor=kColorHexString(kuserThemeBgColor);
}


- (void)initDataSource {
    
}
- (void)initSubViews {
    
}

//初始化自定义导航栏
- (void)initNavViewTitle:(NSString *)title leftTitle:(NSString *)leftTitle action:(SEL)dismissViewController{
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSTATUSBAR_HEIGHT+kNAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:navView];
    
    UIImageView *bgimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, navView.height)];
    bgimageV.backgroundColor=[UIColor blackColor];
    bgimageV.alpha=0.5;
    [navView addSubview:bgimageV];
    
    self.lab_title=[[YJThemeLabel alloc]initWithFrame:CGRectMake(0, kSTATUSBAR_HEIGHT, kSCREEN_WIDTH, kNAVIGATIONBAR_HEIGHT)];
    [navView addSubview:self.lab_title];
    self.lab_title.text=title;
    self.lab_title.textAlignment=NSTextAlignmentCenter;
    self.lab_title.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 20);
    
    self.btn_cancel=[[YJThemeButton alloc]initWithFrame:CGRectMake(0, kSTATUSBAR_HEIGHT, 44, kNAVIGATIONBAR_HEIGHT)];
    [navView addSubview:self.btn_cancel];
    [self.btn_cancel setTitle:leftTitle forState:UIControlStateNormal];
    [self.btn_cancel addTarget:self action:dismissViewController forControlEvents:UIControlEventTouchUpInside];
    self.btn_cancel.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
    
}
- (void)reloadNavView {
    self.lab_title.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 20);
    self.btn_cancel.titleLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
