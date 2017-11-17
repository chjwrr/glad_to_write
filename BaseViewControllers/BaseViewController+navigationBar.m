//
//  BaseViewController+navigationBar.m
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController+navigationBar.h"
#import <objc/runtime.h>

static void *leftBlock=&leftBlock;
static void *rightBlock=&rightBlock;

static void *rightLeftBlock=&rightLeftBlock;
static void *rightRightBlock=&rightRightBlock;

static void *lab_title=&lab_title;
static void *btn_cancel=&btn_cancel;


@implementation BaseViewController (navigationBar)
@dynamic leftNavBarBlock,rightNavBarBlock,rightNavBarBlockLeft,rightNavBarBlockRight;

#pragma leftNavBarBlock  set  and   get
- (void)setLeftNavBarBlock:(LeftNarBarBlock)leftNavBarBlock {
    objc_setAssociatedObject(self, &leftBlock, leftNavBarBlock, OBJC_ASSOCIATION_COPY);
}
- (LeftNarBarBlock)leftNavBarBlock {
    return objc_getAssociatedObject(self, &leftBlock);
}

#pragma rightNavBarBlock  set  and   get
- (void)setRightNavBarBlock:(RightNarBarBlock)rightNavBarBlock {
    objc_setAssociatedObject(self, &rightBlock, rightNavBarBlock, OBJC_ASSOCIATION_COPY);
}
- (RightNarBarBlock)rightNavBarBlock {
    return objc_getAssociatedObject(self, &rightBlock);
}

#pragma rightNavBarBlockLeft  set  and   get
- (void)setRightNavBarBlockLeft:(RightNarBarBlockLeft)rightNavBarBlockLeft {
    objc_setAssociatedObject(self, &rightLeftBlock, rightNavBarBlockLeft, OBJC_ASSOCIATION_COPY);
}
- (RightNarBarBlockLeft)rightNavBarBlockLeft {
    return objc_getAssociatedObject(self, &rightLeftBlock);
}

#pragma rightNavBarBlockRight  set  and   get
- (void)setRightNavBarBlockRight:(RightNarBarBlockRight)rightNavBarBlockRight {
    objc_setAssociatedObject(self, &rightRightBlock, rightNavBarBlockRight, OBJC_ASSOCIATION_COPY);
}
- (RightNarBarBlockRight)rightNavBarBlockRight {
    return objc_getAssociatedObject(self, &rightRightBlock);
}



- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setTitle:title forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(leftNavBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}
- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_left=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_left setBackgroundColor:[UIColor redColor]];
    [btn_left setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn_left addTarget:self action:@selector(leftNavBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.leftBarButtonItems=@[space,bar];
}


- (void)leftNavBarAction {
    self.leftNavBarBlock();
}




- (void)initRithNavigationBarButtonWithTitle:(NSString *)title {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setBackgroundColor:[UIColor redColor]];
    [btn_right setTitle:title forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(rightNavBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}
- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setBackgroundColor:[UIColor redColor]];
    [btn_right setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(rightNavBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar];
}

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2 {
    UIButton *btn_right=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btn_right setBackgroundColor:[UIColor redColor]];
    btn_right.tag=101;
    [btn_right setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn_right1=[[UIButton alloc]initWithFrame:CGRectMake(44, 0, 44, 44)];
    [btn_right1 setBackgroundColor:[UIColor greenColor]];
    [btn_right1 setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [btn_right1 addTarget:self action:@selector(doubleRightAction:) forControlEvents:UIControlEventTouchUpInside];
    btn_right1.tag=100;
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc]initWithCustomView:btn_right];
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithCustomView:btn_right1];
    
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width=-10;
    
    
    self.navigationItem.rightBarButtonItems=@[space,bar,space,bar1,space];
}


- (void)rightNavBarAction {
    self.rightNavBarBlock();
}

- (void)doubleRightAction:(UIButton *)button {
    if (button.tag == 100) {
        self.rightNavBarBlockLeft();
    }else
        self.rightNavBarBlockRight();
    
}

@end
