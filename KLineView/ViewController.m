//
//  ViewController.m
//  KLineView
//
//  Created by qikai on 16/7/28.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "ViewController.h"
#import "ZhuLineView.h"
#import "SendData.h"
#import "KLineView.h"

@interface ViewController ()
{
    KLineView *_klineView;
    int dateNum;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SendData *sendData = [[SendData alloc] init];
    NSArray *datas = [sendData getKLineDataWithType:@"type1" WithLastTime:[[NSDate date] timeIntervalSince1970] WithTIMETYPE:0];
    [self creatKLineView];
    _klineView.decimalNum = 5;
    _klineView.allDataArr = datas;
    [_klineView setUpdataBlockWithBlock:^(BOOL isAdd) {
        if (isAdd == YES) {
            //加载数据
            NSMutableArray *allDatas = [NSMutableArray array];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [allDatas addObjectsFromArray:_klineView.allDataArr];
                NSArray *addData= [sendData getKLineDataWithType:@"type1" WithLastTime:[[NSDate date] timeIntervalSince1970] - 60 *100 *dateNum WithTIMETYPE:0];
                [allDatas addObjectsFromArray:addData];
                _klineView.allDataArr = allDatas;
                //数据加载完成之后需要需要调整scroll的contentOffSet
                [_klineView setContentOffset:CGPointMake(_klineView.lastSaveLocationX + 300, 0)];
            });
        }
    }];
    [_klineView initProperty];
    [_klineView setNeedsDisplay];
    
}
-(void)creatKLineView{
    _klineView = [[KLineView alloc] initWithFrame:CGRectMake(0, 100, 375, 500)];
    _klineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_klineView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
