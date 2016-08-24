//
//  OtherLineView.h
//  KLineView
//
//  Created by qikai on 16/8/22.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "ZhuLineView.h"

@interface OtherLineView : ZhuLineView
//有MA线
@property (nonatomic ,assign )BOOL hasMAChart;
//MA线对应的属性
@property (nonatomic ,assign )int numOfMA;
@property (nonatomic ,strong )NSArray *maLineColors;


-(void)initProperty;

@end
