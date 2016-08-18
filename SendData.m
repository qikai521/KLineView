//
//  SendData.m
//  KLineView
//
//  Created by qikai on 16/8/18.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "SendData.h"
#define kSendDataCount 100
/**
 *  模拟获得K线的数据，其中包括type，time，
 */


//假设价格在0.53000到 0.54500之间变动
typedef enum : NSUInteger {
    PRICETYPE_Open,
    PRICETYPE_Low,
    PRICETYPE_High,
    PRICETYPE_Close,
} PRICETYPE;


@implementation SendData

-(NSArray *)getKLineDataWithType:(NSString *)type
                    WithLastTime:(double)timeInterval
                    WithTIMETYPE:(TIMETYPE )timeType{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < kSendDataCount; i++) {
        if (self.lastOpen == 0 && self.lastClose == 0) {
            self.lastOpen = 0.53223;
            self.lastClose = 0.53223*1.02;
        }
        //时间
        timeInterval = timeInterval - i * 60;
        //开盘价格,首先获取到开盘价格
        double openPrice = [self backPriceWithPrice:self.lastClose];
        double lowPrice = [self backPriceWithPrice:openPrice];
        
        double highPrice = [self backPriceWithHighPrice:openPrice * 1.1 WithLowPrice:lowPrice];
        double closePrce = [self backPriceWithHighPrice:highPrice WithLowPrice:lowPrice];
        NSDictionary *dic = @{@"type":@"type1",
                              @"timeInterval":[NSNumber numberWithInt:(int)timeInterval],
                              @"open":[NSNumber numberWithDouble:openPrice],
                              @"close":[NSNumber numberWithDouble:closePrce],
                              @"high":[NSNumber numberWithDouble:highPrice],
                              @"low":[NSNumber numberWithDouble:lowPrice]};
        [dataArray addObject:dic];
        self.lastClose = closePrce;
    }
    return dataArray;
}
/**
 *   //根据一个基本值 然后在+ - 10%的范围内任意的取值
 *   适应于获取开盘值和获取最低值（因为最高值是以最低值来获取的）
 */

-(double )backPriceWithPrice:(double )nowPrice
{
    double returnPrice;
    double returnInt;
    //真正的价格*100000之后
    int nowPriceInt = (int)(nowPrice * pow(10, 5));
    int rangePriceInt = (int)(nowPriceInt * 0.2);
    returnInt = arc4random()%rangePriceInt + (int)(nowPriceInt * 0.9);
    returnPrice = returnInt * pow(0.1, 5);
    return returnPrice;
}

/**
 *  根据最高值和最低值获取中间一个值
 */
-(double )backPriceWithHighPrice:(double )highPrice
                    WithLowPrice:(double )lowPrice{
    int lowPriceInt = (int)(lowPrice * pow(10, 5));
    int highPriceInt = (int)(highPrice * pow(10, 5));
    int rangePriceInt = highPriceInt - lowPriceInt;
    int backInt = lowPriceInt + arc4random()%rangePriceInt;
    double returnDouble = backInt * pow(0.1, 5);
    return returnDouble;
    
}


@end
