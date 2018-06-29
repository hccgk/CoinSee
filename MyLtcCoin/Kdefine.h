//
//  Kdefine.h
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#ifndef Kdefine_h
#define Kdefine_h

#define kBaseUrl @"https://api.fcoin.com/v2/market/"
#define kFtBtc @"btcusdt"
#define kFtUsdt @"ftusdt"
#define kFtEth @"ltcusdt"
#define kDepth @"depth/"
#define kTrades @"trades/"
#define kKline @"candles/"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

// Tabbar height.
#define  kTabbarHeight         (kIsiPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  kTabbarSafeBottomMargin         (kIsiPhoneX ? 34.f : 0.f)


#define kIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height   //普通的是20 iPhone X 是40
#define kNavBarHeight 44.0
#define kNavH (kStatusBarHeight + kNavBarHeight)

///api/v1/kline.do
#endif /* Kdefine_h */
