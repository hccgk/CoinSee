//
//  buysaleModel.h
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface buysaleModel : JSONModel
@property(nonatomic,strong)NSNumber *price;
@property(nonatomic,strong)NSNumber *number;
@property(nonatomic,strong)NSString *pId;
@end
