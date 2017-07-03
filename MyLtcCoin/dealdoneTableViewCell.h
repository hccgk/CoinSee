//
//  dealdoneTableViewCell.h
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dealDoneModel.h"

@interface dealdoneTableViewCell : UITableViewCell
@property(nonatomic,strong) dealDoneModel *ddmodle;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UILabel *monyLable;
@property(nonatomic,strong) UILabel *amountLable;
@end
