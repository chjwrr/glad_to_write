//
//  BaseNavigationController.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontColor:) name:kThemeColorChangeNotificationName object:nil];
    
    
    [self changeViewBgColor];

}
- (void)changeFontColor:(NSNotification *)tification {
    [self changeViewBgColor];
}

- (void)changeViewBgColor {

    [self.navigationBar setBarTintColor:kColorHexString(kuserThemeBgColor)];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kColorHexString(kuserThemeFontColor),NSFontAttributeName:[UIFont systemFontOfSize:18]};
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
