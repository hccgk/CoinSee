//
//  NetWorkTools.m
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools
+(instancetype)shareTools{
    static NetWorkTools *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self =  [[NetWorkTools manager] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    return self;
}

@end
