//
//  BaseViewController+MJRefresh.h
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (MJRefresh)


@property (nonatomic,strong)MJRefreshNormalHeader *header;
@property (nonatomic,strong)MJRefreshBackNormalFooter *footer;


- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (void)headerRefreshHiddent:(BOOL)hiddent;

- (void)footerRefreshHiddent:(BOOL)hiddent;

- (void)headerEndRefresh;

- (void)footerEndRefresh;

- (void)endRefresh;


@end
