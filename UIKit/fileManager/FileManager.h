//
//  FileManager.h
//  NSFileManager测试
//
//  Created by apple on 15/5/5.
//  Copyright (c) 2015年 CHJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (id)shareIntance;

/*创建缓存目录*/
- (void)creatMyWayFilePath;

/*返回视频文件夹地址*/
- (NSString *)videoFilePath;

/*返回音频文件夹地址*/
- (NSString *)audeoFilePath;

/*返回图片文件夹地址*/
- (NSString *)imageFilePath;

/*移除某一个视频*/
- (void)removeAudeoFilePathWithItemName:(NSString *)name;

/*移除某一个音频*/
- (void)removeVideoFilePathWithItemName:(NSString *)name;

/*移除某一个图片*/
- (void)removeImageFilePathWithItemName:(NSString *)name;

/*删除所有的视频*/
- (void)removeAllVideoItems;

/*删除所有的音频*/
- (void)removeAllAudeoItems;

/*删除所有的图片*/
- (void)removeAllImageItems;

/*获取所有的视频*/
- (NSArray *)getAllVideoItems;

/*获取所有的音频*/
- (NSArray *)getAllAudeoItems;

/*获取所有的图片*/
- (NSArray *)getAllImageItems;

- (void)saveContent:(NSDictionary *)content ToFilePath:(NSString *)filepath;

- (NSDictionary *)getContentFromFilePath:(NSString *)filepath;






//创建日记
- (void)creatNotePlist:(NSString *)noteName noteData:(NSDictionary *)diction;

//获取所有日记
- (NSArray *)getAllNoteItems;

//通过日记名字获取日记路径
- (NSString *)getNoteFilePathWithNoteName:(NSString *)noteName;

//通过路径获取日记
- (NSDictionary *)getNoteWithFilePath:(NSString *)filePath;

@end
