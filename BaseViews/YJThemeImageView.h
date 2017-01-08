//
//  YJThemeImageView.h
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJThemeImageView : UIImageView

@property (nonatomic,strong)NSString *imageName;


- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)name;

@end
