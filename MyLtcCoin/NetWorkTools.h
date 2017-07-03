//
//  NetWorkTools.h
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFHTTPSessionManager.h"

@interface NetWorkTools : AFHTTPSessionManager
+(instancetype)shareTools;
@property(nonatomic,copy)NSString *coinType;
@end
