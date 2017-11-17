//
//  CHJProgressHUB.h
//  yueJi
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

@interface CHJProgressHUB : BaseView

+ (instancetype)shareInstance;

- (void)showMessage:(NSString *)message;

@end
