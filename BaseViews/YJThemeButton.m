//
//  YJThemeButton.m
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJThemeButton.h"

@implementation YJThemeButton


- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageName=name;
        
        [self addNotification];
    }
    return self;
}

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
    
    [self changeSelfTitleColorOrImage];

}


- (void)changeFontColor:(NSNotification *)tification {
    
    [self changeSelfTitleColorOrImage];
    
}

- (void)changeSelfTitleColorOrImage {
    if (self.imageName) {
         NSString *imageFilePath=[NSString stringWithFormat:@"%@/%@",kgetDefaultValueForKey(kuserTheme),self.imageName];
        [self setImage:kImageName(imageFilePath) forState:UIControlStateNormal];
    }
        
    [self setTitleColor:kColorHexString(kuserThemeFontColor) forState:UIControlStateNormal];
    
}

- (void)changeImageName:(NSString *)imageName {
    self.imageName=imageName;
    
    [self changeSelfTitleColorOrImage];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
