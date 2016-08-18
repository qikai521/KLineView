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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    NSDate *date  = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"%@",dateString);
    
    NSTimeInterval timeIntervalue  = [date timeIntervalSince1970];
    timeIntervalue =  timeIntervalue - 3600;
    NSDate *addDate = [NSDate dateWithTimeIntervalSince1970:timeIntervalue];
    NSLog(@"%@",[dateFormatter stringFromDate:addDate]);
    
    SendData *sendData = [[SendData alloc] init];
    NSArray *datas = [sendData getKLineDataWithType:@"type1" WithLastTime:[[NSDate date] timeIntervalSince1970] WithTIMETYPE:0];
    NSLog(@"%@",datas);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
