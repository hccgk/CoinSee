//
//  dealDoneModel.m
//  MyLtcCoin

//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import "dealDoneModel.h"

@implementation dealDoneModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"date":@"ts",@"tid":@"id",
                                                                  @"type":@"side"
                                                                  }];
}
@end
