//
//  LocationManager.h
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^LocationSuccessBlock)(NSString *address);
typedef void(^LocationFailBlock)(NSString *error);

@interface LocationManager : NSObject


@property (nonatomic,copy)LocationFailBlock failBlock;
@property (nonatomic,copy)LocationSuccessBlock successBlock;

+ (id)shareInStance;

- (void)startUserLocation:(LocationSuccessBlock)succBlock fail:(LocationFailBlock)failBlock;

- (void)stopUserLocation;
@end
