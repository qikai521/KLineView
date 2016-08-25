//
//  SendData.h
//  KLineView
//
//  Created by qikai on 16/8/18.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TIMETYPE_OneMinute,
    TIMETYPE_TwoMinute,
    TIMETYPE_OneHour,
} TIMETYPE;

@interface SendData : NSObject


@property (nonatomic ,assign )double lastOpen;
@property (nonatomic ,assign )double lastClose;


-(NSArray *)getKLineDataWithType:(NSString *)type
                    WithLastTime:(double)timeInterval
                    WithTIMETYPE:(TIMETYPE )timeType;


@end
