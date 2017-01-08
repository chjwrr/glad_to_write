//
//  YJThemeImageView.m
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJThemeImageView.h"

@implementation YJThemeImageView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageName=name;
        
        [self addNotification];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
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
    
    [self changeSelfImageOrBgColor];
}


- (void)changeFontColor:(NSNotification *)tification {
    
    [self changeSelfImageOrBgColor];

}

- (void)changeSelfImageOrBgColor {
    if (self.imageName) {
        NSString *imageFilePath=[NSString stringWithFormat:@"%@/%@",kgetDefaultValueForKey(kuserTheme),self.imageName];
        self.image=kImageName(imageFilePath);
    }else{
        self.backgroundColor=kColorHexString(kuserThemeFontColor);
    }

}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
