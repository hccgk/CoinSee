//
//  NewsViewController.m
//  MyLtcCoin
//
//  Created by 川何 on 2017/6/26.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import "NewsViewController.h"
#import "buysaleModel.h"
#import "buysaleTableViewCell.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *buyArray;
@property(nonatomic,strong)NSArray *saleArray;
@property(nonatomic,strong) UITableView *tableview;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买卖全档";
    [self makeData];
    
  
}
     
-(void)addTimeRefresh{
         // 获得队列
         dispatch_queue_t queue = dispatch_get_main_queue();
         
         // 创建一个定时器(dispatch_source_t本质还是个OC对象)
         self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
         
         // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
         // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
         // 何时开始执行第一个任务
         // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
         dispatch_time_t start = dispatch_time((int64_t)(1.0 * NSEC_PER_SEC), (int64_t)(1.0 * NSEC_PER_SEC));
         uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
         dispatch_source_set_timer(self.timer, start, interval, 0);
         
         // 设置回调
         dispatch_source_set_event_handler(self.timer, ^{
             [self reloadData];
         });
         
         // 启动定时器
         dispatch_resume(self.timer);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _buyArray = nil;
    _timer = nil;
    _saleArray = nil;
    _tableview = nil;
    [self makeData];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 取消定时器
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    [self.tableview.mj_header endRefreshing];
}
-(void)makeData{
//    NSString *coinType = [NetWorkTools shareTools].coinType;
    NSString *urlstring = [NSString stringWithFormat:@"%@full/%@",kDepth, [NetWorkTools shareTools].coinType];

    [[NetWorkTools shareTools] GET:urlstring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _buyArray = nil;
        _saleArray = nil;
        NSArray *getsalArray = [[NSArray arrayWithObject:responseObject[@"data"][@"asks"]] firstObject] ;
        NSMutableArray *mutarray = [NSMutableArray array];
        for (int i = 0; i<getsalArray.count; i++) {
            buysaleModel *model = [[buysaleModel alloc] init];
            model.price = getsalArray[i];
            model.number = getsalArray[++i];
            model.pId = [NSString stringWithFormat:@"卖%d",i/2+1];
            [mutarray addObject:model];
        }
        _buyArray = mutarray;
        
        NSArray *getbuyArray = [[NSArray arrayWithObject:responseObject[@"data"][@"bids"]] firstObject];
        NSMutableArray *mutbuyArr = [NSMutableArray array];
        for (int i =0 ; i<getbuyArray.count; i++) {
            buysaleModel *model = [[buysaleModel alloc] init];
            model.price = getbuyArray[i];
            model.number = getbuyArray[++i];
            model.pId = [NSString stringWithFormat:@"买%d",i/2+1];
            [mutbuyArr addObject:model];
        }
        _saleArray = mutbuyArr;
        [self makeUI];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableview.mj_header endRefreshing];

    }];
    
}

-(void)reloadData{

    NSString *urlstring = [NSString stringWithFormat:@"%@full/%@",kDepth, [NetWorkTools shareTools].coinType];
    
    [[NetWorkTools shareTools] GET:urlstring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _buyArray = nil;
        _saleArray = nil;
        NSArray *getsalArray = [[NSArray arrayWithObject:responseObject[@"data"][@"asks"]] firstObject] ;
        NSMutableArray *mutarray = [NSMutableArray array];
        for (int i = 0; i<getsalArray.count; i++) {
            buysaleModel *model = [[buysaleModel alloc] init];
            model.price = getsalArray[i];
            model.number = getsalArray[++i];
            model.pId = [NSString stringWithFormat:@"卖%d",i/2+1];
            [mutarray addObject:model];
        }
        _buyArray = mutarray;
        
        NSArray *getbuyArray = [[NSArray arrayWithObject:responseObject[@"data"][@"bids"]] firstObject];
        NSMutableArray *mutbuyArr = [NSMutableArray array];
        for (int i =0 ; i<getbuyArray.count; i++) {
            buysaleModel *model = [[buysaleModel alloc] init];
            model.price = getbuyArray[i];
            model.number = getbuyArray[++i];
            model.pId = [NSString stringWithFormat:@"买%d",i/2+1];
            [mutbuyArr addObject:model];
        }
        _saleArray = mutbuyArr;
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableview.mj_header endRefreshing];
        
    }];
    
    
 
}
-(void)makeUI{
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    [self.view addSubview:self.tableview];
    [self addTimeRefresh];
//    [self performSelector:@selector(addTimeRefresh) withObject:nil afterDelay:2.0];
}

-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64 - 50) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

#pragma -mart UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _saleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static  NSString *resuID = @"busaleresumid";
    buysaleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuID];
    if (!cell) {
        cell = [[buysaleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    buysaleModel *buyModel = _buyArray[indexPath.row];
    buysaleModel *saleModel = _saleArray[indexPath.row];
    cell.buymodel = buyModel;
    cell.salemodel = saleModel;
    
    return cell;
}
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
