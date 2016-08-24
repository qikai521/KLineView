//
//  ZhuLineView.h
//  KLineView
//
//  Created by qikai on 16/8/18.
//  Copyright © 2016年 qikai. All rights reserved.
//

/**
 *  柱状图的宽度是和showArr 的数量有关系的 showArr 介于8~126条数据之间对应的宽度则应该是边框的宽度
 每个item 的宽度应该包括显示的柱状图区域和空白的区域两部分构成 其中空白的部分应该是item的宽度的1/4
 *
 */

#import "BaseLineView.h"
#import "UIColor+KLineColor.h"

@interface ZhuLineView : BaseLineView


/**
 *  柱状图的边框颜色，rect上涨时和下跌时的颜色
 */
@property (nonatomic ,strong )UIColor *candleLineColor;
@property (nonatomic ,strong )UIColor *candleUpColor;
@property (nonatomic ,strong )UIColor *candleDownColor;
/**
 */
@property (nonatomic , assign )double candleItemWidth;

-(void)initProperty;
/**
 *  根据数据的value值获取到所在的位置
 */
-(double )getCoodYValueWithDoubleValue:(double )doubleValue;

@end
