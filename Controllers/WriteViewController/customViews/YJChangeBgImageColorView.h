//
//  YJChangeBgImageColorView.h
//  yueJi
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

typedef void(^YJChangeBgImageColorViewBlock)(NSString *name);

@interface YJChangeBgImageColorView : BaseView

@property (nonatomic,copy)YJChangeBgImageColorViewBlock selectBlock;

+ (instancetype)shareInstance;

- (void)show:(NSArray *)array success:(YJChangeBgImageColorViewBlock)block;

- (void)hiddent;

@end
