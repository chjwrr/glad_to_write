//
//  BaseView.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView


- (instancetype)init {
    self=[super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    
    if(self){
        [self initSubView];
    }
    
    return self;
}

- (void)initSubView {
    
}
@end
