//
//  ViewController.m
//  KLineView
//
//  Created by qikai on 16/7/28.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "ViewController.h"
#import "BaseModel.h"
#import "SendData.h"
#import "KLineView.h"

@interface ViewController ()
{
    BaseLineView *_klineView;
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
    [_klineView initProperty];
    [_klineView setNeedsDisplay];
    
}
-(void)creatKLineView{
    _klineView = [[BaseLineView alloc] initWithFrame:CGRectMake(0, 100, 375, 500)];
    _klineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_klineView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
