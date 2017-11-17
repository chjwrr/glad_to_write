//
//  BaseViewController+MJRefresh.m
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController+MJRefresh.h"

static void *head=&head;
static void *food=&food;


@implementation BaseViewController (MJRefresh)
@dynamic header,footer;



//tableview下拉刷新  上拉加载

/*
 self.tableview.mj_header=[self addTableViewRefreshHeaderWithTarget:self action:@selector(headerRefresh)];
 self.tableview.mj_footer=[self addTableViewRefreshFooterWithTarget:self action:@selector(footerRefresh)];
 
 */


#pragma header  set  and   get
- (void)setHeader:(MJRefreshNormalHeader *)header {
    objc_setAssociatedObject(self, &head, header, OBJC_ASSOCIATION_RETAIN);
}
- (MJRefreshNormalHeader *)header {
    return objc_getAssociatedObject(self, &head);
}

#pragma footer  set  and   get
- (void)setFooter:(MJRefreshBackNormalFooter *)footer {
    objc_setAssociatedObject(self, &food, footer, OBJC_ASSOCIATION_RETAIN);
}
- (MJRefreshBackNormalFooter *)footer {
    return objc_getAssociatedObject(self, &food);
}



- (MJRefreshNormalHeader *)addTableViewHeaderRefreshingTarget:(id)target refreshingAction:(SEL)action {
    self.header=[MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    return self.header;
}

- (MJRefreshBackNormalFooter *)addTableViewFooterRefreshingTarget:(id)target refreshingAction:(SEL)action {
    self.footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    return self.footer;
}

- (void)headerRefreshHiddent:(BOOL)hiddent {
    self.header.hidden=hiddent;
}
- (void)footerRefreshHiddent:(BOOL)hiddent {
    self.footer.hidden=hiddent;
}
- (void)headerEndRefresh {
    [self.header endRefreshing];
}
- (void)footerEndRefresh {
    [self.footer endRefreshing];
}
- (void)endRefresh {
    [self.header endRefreshing];
    [self.footer endRefreshing];
}


@end
