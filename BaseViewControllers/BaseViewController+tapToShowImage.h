//
//  BaseViewController+tapToShowImage.h
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (tapToShowImage)


/**
 *  点击放大图片
 *
 *  @param selectIndex 点击的第几张图片
 *  @param photos      图片数组
 */
- (void)jumpBigImageWithSelectIndex:(NSInteger)selectIndex WithPhotos:(NSMutableArray *)photos;


@end
