//
//  YJActionSheet.h
//  yueJi
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseView.h"

@protocol YJActionSheetDelegate <NSObject>

- (void)YJActionSheet:(id)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end


@interface YJActionSheet : BaseView

@property (nonatomic,weak)id<YJActionSheetDelegate>delegate;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle destructiveButtonTitle:(NSString *)destructiveTitle otherButtonTitles:(NSArray *)btns;

- (void)showInView:(UIView *)supView;

@end

