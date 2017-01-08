//
//  BaseViewController+tapToShowImage.m
//  ModelProduct
//
//  Created by apple on 16/11/8.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseViewController+tapToShowImage.h"

@interface BaseViewController ()<MWPhotoBrowserDelegate>

@property (nonatomic,strong)NSMutableArray *photos;


@end

static void *photo=&photo;


@implementation BaseViewController (tapToShowImage)


#pragma header  set  and   get
- (void)setPhotos:(NSMutableArray *)photos {
    objc_setAssociatedObject(self, &photo, photos, OBJC_ASSOCIATION_RETAIN);
}
- (NSMutableArray *)photos {
    return objc_getAssociatedObject(self, &photo);
}

/**
 *  MWPhotoBrowser
 *
 *  @param selectIndex  点击查看大图
 */

- (void)jumpBigImageWithSelectIndex:(NSInteger)selectIndex WithPhotos:(NSMutableArray *)photos{
    
    self.photos=[[NSMutableArray alloc]initWithArray:photos];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;//弹出分享保存等选项右上方
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = NO;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = YES;
    [browser setCurrentPhotoIndex:selectIndex];
    browser.delegate=self;
    self.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:browser animated:YES];
    
}

#pragma mark - MWPhotoBrowserDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
/* 
 Category is implementing a method which will also be implemented by its primary class  这个警告的意思是 我在category中重写了原类的方法 而苹果的官方文档中明确表示  我们不应该在category中复写原类的方法，如果要重写 请使用继承
 */

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

#pragma clang diagnostic pop



- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    return nil;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return YES;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
