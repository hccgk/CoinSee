//
//  dealDoneModel.h
//  MyLtcCoin
/*
 "date": "1367130137",
 "date_ms": "1367130137000",
 "price": 787.5,
 "amount": 0.091,
 "tid": "230435",
 "type": "sell"
 
 date:交易时间
 date_ms:交易时间(ms)
 price: 交易价格
 amount: 交易数量
 tid: 交易生成ID
 type: buy/sell
 *///  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface dealDoneModel : JSONModel
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *tid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong) NSNumber *price;
@property(nonatomic,strong) NSNumber *amount;
@end
