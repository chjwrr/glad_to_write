//
//  BaseViewController+navigationBar.h
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^LeftNarBarBlock)(void);
typedef void(^RightNarBarBlock)(void);

typedef void(^RightNarBarBlockLeft)(void);
typedef void(^RightNarBarBlockRight)(void);



@interface BaseViewController (navigationBar)

@property (nonatomic,copy)LeftNarBarBlock leftNavBarBlock;
@property (nonatomic,copy)RightNarBarBlock rightNavBarBlock;
@property (nonatomic,copy)RightNarBarBlockLeft rightNavBarBlockLeft;
@property (nonatomic,copy)RightNarBarBlockRight rightNavBarBlockRight;



- (void)initLeftNavigationBarButtonWithtTitle:(NSString *)title;

- (void)initLeftNavigationBarButtonWithImage:(NSString *)imageName;

- (void)initRithNavigationBarButtonWithTitle:(NSString *)title;

- (void)initRithNavigationBarButtonWithImage:(NSString *)imageName;

- (void)initRithNavigationBarButtonWithDoubleImage:(NSString *)imageName1 otherImage:(NSString *)imageName2;

- (void)initNavViewTitle:(NSString *)title leftTitle:(NSString *)leftTitle action:(SEL)dismissViewController;

- (void)reloadNavView;

@end
