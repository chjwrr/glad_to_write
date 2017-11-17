//
//  DefineHeader.h
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#ifndef ModelProduct_DefineHeader_h
#define ModelProduct_DefineHeader_h

//缓存目录
#define kTXTFilePath                            @"CacheFilePath"

//数据库名称
#define kFMDBName                               @"/Muwood.sqlite"

//数据库路径
#define kFMDBPath                               [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:kFMDBName]

//导航条背景颜色
#define kNavgationBarBackGroundColor            kColorWithRGB(69, 125, 254, 1.0)

//用户位置信息,经纬度
#define kUserLocationLatitude                   @"UserLocationLatitude"
#define kUserLocationLongitude                  @"UserLocationLongitude"

//详细地址信息
#define kUserLocationAddressInfo                @"UserLocationAddressInfo"

//城市
#define kUserLocationCity                       @"UserLocationCity"

//国家
#define kUserLocationCountry                    @"UserLocationCountry"

//用户选择语言
#define kUserlanguage                           @"Userlanguage"


/************************************* 用户密码设置 ******************************************/

//是否开启TouchID
#define kuserTouchID                            @"userTouchID"

//是否开启数字密码
#define kuserOpenPassword                       @"userOpenPassword"

//是否开启数字密码
#define kuserPassword                           @"userPassword"



/************************************* 用户主题 ******************************************/

//更换主题发送通知名称
#define kThemeColorChangeNotificationName      @"ThemeColorChangeNotificationName"

//储存本地主题文件夹
#define kuserTheme                     @"userTheme"

#define kThemePlistFilePath            ([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/ThemeFontColor",kFormatterSring(kgetDefaultValueForKey(kuserTheme))] ofType:@"plist"])

//主题字体颜色
#define kuserThemeFontColor            ([[[NSDictionary alloc]initWithContentsOfFile:kThemePlistFilePath] objectForKey:@"fontColor"])

//主题背景颜色
#define kuserThemeBgColor              ([[[NSDictionary alloc]initWithContentsOfFile:kThemePlistFilePath] objectForKey:@"themeColor"])

//储存程序字体大小，只限于发布的文字
#define kuserFontSizeName              @"userFontSizeName"

//程序字体大小，只限于发布的文字
#define kuserFontSize                  (kFormatterSring(kgetDefaultValueForKey(kuserFontSizeName)).integerValue)

//储存程序字体行间距,只限于发布的文字
#define kuserFontSpaceHeight           @"userFontSpaceHeight"

//程序字体行间距，只限于发布的文字
#define kuserFontSpace                 (kFormatterSring(kgetDefaultValueForKey(kuserFontSpaceHeight)).integerValue)

//储存程序字体字间距,只限于发布的文字
#define kuserFontSpaceWidth            @"userFontSpaceWidth"

//程序字体字间距，只限于发布的文字
#define kuserFontWidthSpace            (kFormatterSring(kgetDefaultValueForKey(kuserFontSpaceWidth)).integerValue)

//字体名字
#define kuserFontName                  @"userFontName"

//字体名字汉字
#define kuserFontNameChina             @"userFontNameChina"


/************************************* 用户日记背景 ******************************************/

//日记背景图
#define kuserNoteBgImage               @"userNoteBgImage"

#endif
