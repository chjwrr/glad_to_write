//
//  YJThemeLabel.m
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJThemeLabel.h"

@implementation YJThemeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self addNotification];
    }
    return self;
}
- (instancetype)init {
    self=[super init];
    if (self) {
        [self addNotification];
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontColor:) name:kThemeColorChangeNotificationName object:nil];
    
    [self changeSelfTextColor];

}


- (void)changeFontColor:(NSNotification *)tification {
    
    [self changeSelfTextColor];
    
}

- (void)changeSelfTextColor {
    
    self.textColor=kColorHexString(kuserThemeFontColor);
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
