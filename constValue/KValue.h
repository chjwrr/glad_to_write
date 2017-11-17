//
//  KValue.h
//  聚美商城
//
//  Created by apple on 13-11-29.
//  Copyright (c) 2013年 常会军. All rights reserved.
//


#import <Foundation/Foundation.h>


#define kAPP_System_Version       [[[UIDevice currentDevice] systemVersion] floatValue]

#define kAPP_Bundle_Version       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kDevice_Model             [[UIDevice currentDevice] model]



#define kSCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height

#define kSCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width


/*
 设备              屏幕尺寸    分辨率（pt）       Reader      分辨率（px）
 iPhone  3GS      3.5吋       320x480         @1x          320x480
 iPhone 4/4s      3.5吋       320x480         @2x          640x960
 iPhone 5/5s/5c   4.0吋       320x568         @2x          640x1136
 iPhone 6         4.7吋       375x667         @2x          750x1334
 iPhone 6Plus     5.5吋       414x736         @3x          1242x2208
 iPhone 6s        4.7吋       375x667         @2x          750x1334
 iPhone 6sPlus    5.5吋       414x736         @3x          1242x2208
 iPhone 7         4.7吋       375x667         @2x          750x1334
 iPhone 7Plus     5.5吋       414x736         @3x          1242x2208
 iPhone 8         4.7吋       375x667         @2x          750x1334
 iPhone 8Plus     5.5吋       414x736         @3x          1242x2208
 iPhone X         5.8吋       375x812         @3x          1125x2436
 */

#define iPhone4_4s           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5_5s_5c       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6_6s_7_8      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6P_6sP_7P_8P  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)



// iPhoneX　安全区域=812px—Status Bar (44px) +Home Indicator(34px)

#define kTABBAR_HEIGHT                  (iPhoneX ? 34 + 49 : 49)

#define kNAVIGATIONBAR_HEIGHT           44

#define kSTATUSBAR_HEIGHT               (iPhoneX ? 44 : 20)

#define kTBABARVIEW_TAG                 10086

#define kNAVIGATIONBAR_STATUS_HEIGHT    (kNAVIGATIONBAR_HEIGHT+kSTATUSBAR_HEIGHT)

#define kTABBAR_BOTTOM_HEIGHT           (iPhoneX ? 34 : 0)

#define kAPPDELEGATE                    (AppDelegate *)[UIApplication sharedApplication].delegate



#define kOPEN_URL(url)                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]]

#define kCALL_PHONE(numberphone)                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",numberphone]]]

#define kSEND_MESSAGE_PHONE(numberphone)          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",numberphone]]]


#define kSYS_FONT(x)               [UIFont systemFontOfSize:x]

#define kSYS_BOLDFONT(x)           [UIFont boldSystemFontOfSize:x]

#define kSYS_FONTNAME(x,y)         [UIFont fontWithName:x size:y]

#define kColorWithRGB(R,G,B,ALPHA) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:ALPHA]

#define kColorHexString(color)     [UIColor hx_colorWithHexRGBAString:color]

#define kFormatterSring(string)    [NSString stringWithFormat:@"%@",string]

#define kFormatterInt(value)       [NSString stringWithFormat:@"%d",value]

#define kFormatterFloat(value)     [NSString stringWithFormat:@"%f",value]

#define kImageName(imageName)      [UIImage imageNamed:imageName]

