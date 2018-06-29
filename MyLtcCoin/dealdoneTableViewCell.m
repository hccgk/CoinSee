//
//  dealdoneTableViewCell.m
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/27.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import "dealdoneTableViewCell.h"

@implementation dealdoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    /*时间  金额   数量 */
    
    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW/3.0, 15)];
    _timeLable.font = [UIFont systemFontOfSize:11];
    _timeLable.textColor = [UIColor blackColor];
    _timeLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLable];
    
    _monyLable  = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW/3.0, 0, kScreenW/3.0, 15)];
    _monyLable.font = [UIFont systemFontOfSize:11];
    _monyLable.textColor = [UIColor blackColor];
    _monyLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_monyLable];
    
    _amountLable  = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW * 2.0/3.0, 0, kScreenW/3.0, 15)];
    _amountLable.font = [UIFont systemFontOfSize:11];
    _amountLable.textColor = [UIColor blackColor];
    _amountLable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_amountLable];
    
    
}
/*
 "date": "1367130137",
 "date_ms": "1367130137000",
 "price": 787.5,
 "amount": 0.091,
 "tid": "230435",
 "type": "sell"
 */
-(void)setDdmodle:(dealDoneModel *)ddmodle{
    
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:ddmodle.date.doubleValue/1000];
    _timeLable.text = [date jk_stringWithFormat:[NSDate jk_hmsFormat]];
    if ([ddmodle.type isEqualToString:@"sell"]) {
        _monyLable.textColor = [UIColor greenColor];
        _amountLable.textColor = [UIColor greenColor];

    }else{
        _monyLable.textColor = [UIColor redColor];
        _amountLable.textColor = [UIColor redColor];
    }
    
    _monyLable.text = [NSString stringWithFormat:@"%.6f",ddmodle.price.doubleValue];
    _amountLable.text = [NSString stringWithFormat:@"%.6f",ddmodle.amount.doubleValue];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
