//
//  KLineView.h
//  KLineView
//
//  Created by qikai on 16/8/18.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "ScrollOtherLineView.h"
/**
 *  Kline 封装基本思想，以及需求
  *  1.是基于ScrollView和CoreGraphic的
  *  2.纵坐标的数量，间距，text，都是动态改变的（限定于5~12条之内）
  *  3.横坐标的间距是固定的
  *  4.缩放的原理就是改变每组时间刻度之间显示的item的数量来控制
  *  5.移动的原理就是基于ScrollView，然后判断其滑动的位置，然后来重新设置showArray 来实现移动的效果
  *  6.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
  *  1.
 */

@interface KLineView : ScrollOtherLineView

@end
