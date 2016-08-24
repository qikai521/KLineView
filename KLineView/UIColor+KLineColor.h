//
//  UIColor+KLineColor.h
//  KLineView
//
//  Created by qikai on 16/8/19.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (KLineColor)

/**
 *  柱形图的边框颜色
 */
+(UIColor *)zhuLinecolor;
/**
 *  上涨时，柱形图内填充颜色
 */
+(UIColor *)zhuUpRectColor;
/**
 *  下跌时，柱形图内填充颜色
 */
+(UIColor *)zhuDownRectColor;


@end
