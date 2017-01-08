//
//  YJHomeDownView.h
//  yueJi
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"


@protocol YJHomeDownViewDelegate <NSObject>

- (void)YJHomeDownViewShowState:(BOOL)isShow;

- (void)YJHomeDownViewDidSelectSend;

- (void)YJHomeDownViewDidSelectIndex:(NSInteger)index;

@end
@interface YJHomeDownView : BaseView

@property (nonatomic,weak)id<YJHomeDownViewDelegate>delegate;

+ (CGFloat)viewShowHeight;

+ (CGFloat)viewHiddentwHeight;

- (void)show;

- (void)hiddent;

- (void)reloadDownView;

@end
