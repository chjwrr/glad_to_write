//
//  YJNoteModel.h
//  yueJi
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "BaseModel.h"

@interface YJNoteModel : BaseModel

@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *day;
@property (nonatomic,copy)NSString *week;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *address;
@end
