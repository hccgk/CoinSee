//
//  HomeViewController.m
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/26.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import "HomeViewController.h"
#import  "YKLineChart.h"
#import "FTPopOverMenu.h"

@interface HomeViewController ()
@property(nonatomic,strong)NSArray *CoinType;
@property(nonatomic,copy)NSMutableArray *kLineArr;
@property(nonatomic,strong)YKLineChartView *klineView ;
@property(nonatomic,copy)NSString *timesel;
@property(nonatomic,strong)NSArray *timeselArray;
@property(nonatomic,strong)NSArray *timeselShowArray;
@property(nonatomic,strong)UIButton *timeSelbtn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CoinType = @[@"比特币",@"莱特币",@"以太坊"];
    self.title = @"首页";
    _timesel = @"12hour";
    _timeselArray = @[@"1min",@"3min",@"5min",@"15min",@"30min",@"1hour",@"2hour",@"4hour",@"6hour",@"12hour",@"1day",@"3day",@"1week"];
    _timeselShowArray = @[@"1分钟", @"3分钟", @"5分钟", @"15分钟",@"30分钟", @"1小时", @"2小时", @"4小时",@"6小时", @"12小时",@"1日",@"3日",@"1周"];
    [self makeUI];
}
-(YKLineChartView *)klineView{
    if (!_klineView) {
        _klineView = [[YKLineChartView alloc] initWithFrame:CGRectMake(0, 64, kScreenW , kScreenH - 64-140)];
    }
    return _klineView;
}
-(void)selTime:(UIButton*)btn{

    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 40;
    configuration.menuWidth = 90;
    configuration.textColor = [UIColor blackColor];
    configuration.textFont = [UIFont boldSystemFontOfSize:14];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor blackColor];
    configuration.borderWidth = 0.5;
 
    [FTPopOverMenu showForSender:btn
                   withMenuArray:_timeselShowArray
                      imageArray:@[@"Pokemon_Go_04", @"Pokemon_Go_04", @"Pokemon_Go_04", @"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04",@"Pokemon_Go_04"]
                       doneBlock:^(NSInteger selectedIndex) {
                           _timesel =  _timeselArray[selectedIndex];
                           [_timeSelbtn setTitle:_timeselShowArray[selectedIndex] forState:UIControlStateNormal];
                           [self makeData];
                       } dismissBlock:^{
                       }];
}

-(void)makeUI{
    
    _timeSelbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [_timeSelbtn setTitle:@"12小时" forState:UIControlStateNormal];
    [_timeSelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeSelbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_timeSelbtn addTarget:self action:@selector(selTime:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_timeSelbtn];
    
    UIView *buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 35)];
    buttonview.jk_bottom = self.view.jk_bottom - 60;
    buttonview.jk_centerX = self.view.jk_centerX;
    [self.view addSubview:buttonview];
    
    for (int i = 0; i<3; i++) {
        UIButton *makeDatabutton = [[UIButton alloc] initWithFrame:CGRectMake(i * 90, 0, 80, 35)];
        [buttonview addSubview:makeDatabutton];
        makeDatabutton.tag = 1000+i;
        [makeDatabutton setTitle:_CoinType[i] forState:UIControlStateNormal];
        [makeDatabutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [makeDatabutton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        makeDatabutton.layer.cornerRadius = 4.0;
        makeDatabutton.layer.masksToBounds = YES;
        makeDatabutton.layer.borderColor = [UIColor blackColor].CGColor;
        makeDatabutton.layer.borderWidth = 1.0;
        [makeDatabutton addTarget:self action:@selector(ShowWhatCoin:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *bt = (UIButton*) [self.view viewWithTag:1001];
    [self ShowWhatCoin:bt];
}

-(void)ShowWhatCoin:(UIButton*)btn{
    for (int i = 1000; i<1003; i++) {
        UIButton *bt = (UIButton*) [self.view viewWithTag:i];
        bt.selected = NO;
        bt.layer.borderColor = [UIColor blackColor].CGColor;
    }
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.selected = YES;
    
    switch (btn.tag - 1000) {
        case 0:
            [NetWorkTools shareTools].coinType = kBtc;
            break;
        case 1:
            [NetWorkTools shareTools].coinType = kLtc;
            break;
        case 2:
            [NetWorkTools shareTools].coinType = kEth;
            break;
        default:
            break;
    }
    
    [self makeData];

}

-(void)makeData{
    NSString *coinType = [NetWorkTools shareTools].coinType;
    [[NetWorkTools shareTools] GET:kKline parameters:@{@"symbol":coinType,@"type":_timesel} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *getklineArray = responseObject;
        _kLineArr = [NSMutableArray array];
        for (int i = 0; i<getklineArray.count; i++) {
            NSArray *getItemarr = getklineArray[i];
            YKLineEntity * entity = [[YKLineEntity alloc]init];

            entity.high = [getItemarr[2] floatValue];
            entity.open = [getItemarr[1] floatValue];
            
            entity.low = [getItemarr[3] floatValue];
            
            entity.close = [getItemarr[4] floatValue];
            
            NSDate *date =[NSDate dateWithTimeIntervalSince1970:[getItemarr[0] floatValue]/1000];
             entity.date = [date jk_stringWithFormat:@"yyyy/MM/dd"];

            entity.volume = [getItemarr[5] floatValue];
            [_kLineArr addObject:entity];
        }
        [_kLineArr addObjectsFromArray:_kLineArr];
        [self makeKline];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

-(void)makeKline{

    YKLineDataSet * dataset = [[YKLineDataSet alloc]init];
    dataset.data = _kLineArr;
    dataset.highlightLineColor = [UIColor colorWithRed:60/255.0 green:76/255.0 blue:109/255.0 alpha:1.0];
    dataset.highlightLineWidth = 0.7;
    dataset.candleRiseColor = [UIColor colorWithRed:233/255.0 green:47/255.0 blue:68/255.0 alpha:1.0];
    dataset.candleFallColor = [UIColor colorWithRed:33/255.0 green:179/255.0 blue:77/255.0 alpha:1.0];
    dataset.avgLineWidth = 1.f;
    dataset.avgMA10Color = [UIColor colorWithRed:252/255.0 green:85/255.0 blue:198/255.0 alpha:1.0];
    dataset.avgMA5Color = [UIColor colorWithRed:67/255.0 green:85/255.0 blue:109/255.0 alpha:1.0];
    dataset.avgMA20Color = [UIColor colorWithRed:216/255.0 green:192/255.0 blue:44/255.0 alpha:1.0];
    dataset.candleTopBottmLineWidth = 1;
    [self.view addSubview:self.klineView];
    [self.klineView setupChartOffsetWithLeft:50 top:10 right:10 bottom:10];
    self.klineView.gridBackgroundColor = [UIColor whiteColor];
    self.klineView.borderColor = [UIColor colorWithRed:203/255.0 green:215/255.0 blue:224/255.0 alpha:1.0];
    self.klineView.borderWidth = .5;
    self.klineView.candleWidth = 8;
    self.klineView.candleMaxWidth = 30;
    self.klineView.candleMinWidth = 1;
    self.klineView.uperChartHeightScale = 0.7;
    self.klineView.xAxisHeitht = 25;
//    self.klineView.delegate = self;
    self.klineView.highlightLineShowEnabled = YES;
    self.klineView.zoomEnabled = YES;
    self.klineView.scrollEnabled = YES;
    [self.klineView setupData:dataset];
    

}


//-(void)chartValueSelected:(YKViewBase *)chartView entry:(id)entry entryIndex:(NSInteger)entryIndex
//{
//    
//}
//
//- (void)chartValueNothingSelected:(YKViewBase *)chartView
//{
//}
//
//- (void)chartKlineScrollLeft:(YKViewBase *)chartView
//{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
