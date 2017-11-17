//
//  YJChangeBgImageColorView.m
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJChangeBgImageColorView.h"

#define kviewHeight   200

#define kCellWithReuseIdentifier @"CellWithReuseIdentifier"

@interface YJChangeBgImageColorView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectView;
@property (nonatomic,strong)NSArray *dataSource;

@end

@implementation YJChangeBgImageColorView


+ (instancetype)shareInstance {
    static YJChangeBgImageColorView *view=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        view=[[YJChangeBgImageColorView alloc]init];
    });
    return view;
}

- (void)show:(NSArray *)array success:(YJChangeBgImageColorViewBlock)block{
    
    self.dataSource=array;
    self.selectBlock=block;
    
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
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource=dataSource;
    
    [self.collectView reloadData];
}
- (void)initSubView {
    
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
    return [_dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellWithReuseIdentifier forIndexPath:indexPath];
    
    for (UIImageView *aa in [cell.contentView subviews]) {
        if (aa.tag == indexPath.row+100) {
            [aa removeFromSuperview];
        }
    }
    
    UIImageView *imagevieww=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, kviewHeight)];
    [cell.contentView addSubview:imagevieww];
    imagevieww.tag=100+indexPath.row;
    imagevieww.image=kImageName([_dataSource objectAtIndex:indexPath.row]);
    imagevieww.layer.masksToBounds=YES;
    imagevieww.contentMode=UIViewContentModeScaleAspectFill;
    
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
    
    NSString *str_select=kFormatterSring([_dataSource objectAtIndex:indexPath.row]);
    str_select=[str_select substringFromIndex:6];
    //背景色
    ksetDefaultValueForKey(str_select, kuserNoteBgImage);
    
    self.selectBlock(str_select);
    
    
    [self hiddent];
}



@end
