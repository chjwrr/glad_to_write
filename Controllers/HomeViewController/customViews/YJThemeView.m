//
//  YJThemeView.m
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJThemeView.h"

#define kviewHeight   200

#define kCellWithReuseIdentifier @"CellWithReuseIdentifier"

@interface YJThemeView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectView;
@property (nonatomic,copy)NSArray *colors;

@end

@implementation YJThemeView


+ (instancetype)shareInstance {
    static YJThemeView *view=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        view=[[YJThemeView alloc]init];
    });
    return view;
}

- (void)show {
    self.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kviewHeight);

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    

    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame=CGRectMake(0, kSCREEN_HEIGHT-kviewHeight, kSCREEN_WIDTH, kviewHeight);

    } completion:^(BOOL finished) {
        if (finished) {
            self.layer.shadowColor = [UIColor blackColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(0,0);
            self.layer.shadowOpacity = 0.5;
            self.layer.shadowRadius = 4;
        }
    }];
    
}

- (void)hiddent {
    if (self.y == kSCREEN_HEIGHT) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame=CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kviewHeight);
        
    } completion:^(BOOL finished) {
        if (finished) {

            self.layer.shadowColor = [UIColor clearColor].CGColor;
            self.layer.shadowOffset = CGSizeMake(0,0);
            self.layer.shadowOpacity = 1;
            self.layer.shadowRadius = 0;
            
            [self removeFromSuperview];
        }
    }];

}

- (void)initSubView {
    //背景颜色 FAFAD2 浅黄
    //背景颜色 F0FFF0 浅绿
    //背景颜色 EED2EE 浅粉
    //背景颜色 FFC1C1 浅紫
    //背景颜色 87CEFA 浅蓝
    //背景颜色 EBEBEB 浅灰

    _colors=@[@"FAFAD2",@"F0FFF0",@"EED2EE",@"FFC1C1",@"87CEFA",@"EBEBEB"];
    
    [self addSubview:self.collectView];
}

- (UICollectionView *)collectView {
    if (!_collectView) {
        

        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kviewHeight) collectionViewLayout:layout];
        _collectView.backgroundColor=[UIColor clearColor];
        _collectView.delegate=self;
        _collectView.dataSource=self;
        [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellWithReuseIdentifier];
        
    }
    return _collectView;
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_colors count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellWithReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor=kColorHexString([_colors objectAtIndex:indexPath.row]);
    
    return cell;
}


#pragma mark --- UICollectViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, kviewHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark ---- UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *themName=[NSString stringWithFormat:@"theme%d",indexPath.row+1];
    
    ksetDefaultValueForKey(themName, kuserTheme);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeColorChangeNotificationName object:nil];
    
    [self hiddent];
}



@end
