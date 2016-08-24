//
//  UIColor+KLineColor.m
//  KLineView
//
//  Created by qikai on 16/8/19.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "UIColor+KLineColor.h"

@implementation UIColor (KLineColor)

+(UIColor *)zhuLinecolor{
//    return [UIColor colorWithRed:0 green:155.0/255.0 blue:0 alpha:1];
    return [UIColor greenColor];
}

+(UIColor *)zhuUpRectColor{
    return [UIColor whiteColor];
}

+(UIColor *)zhuDownRectColor{
    return [UIColor blackColor];
}

@end
