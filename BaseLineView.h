//
//  BaseLineView.h
//  fenshiDemo
//
//  Created by qikai on 16/6/14.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLineView : UIView

@property (nonatomic ,strong)NSArray *showDataArr;//展示出来的数据w
@property (nonatomic ,strong)UIColor *separaLineColor;//分割线的颜色
@property (nonatomic ,strong)UIColor *coordingYColor;//Y坐标text的颜色
@property (nonatomic ,assign)int decimalNum;//保留到小数点后多少位
@property(assign, nonatomic) CGFloat axisMarginLeft;//绘制区域的left
@property(assign, nonatomic) CGFloat axisMarginBottom;
@property(assign, nonatomic) CGFloat axisMarginTop;
@property(assign, nonatomic) CGFloat axisMarginRight;
@property(assign, nonatomic) int fontNum;//字体大小

@property (nonatomic ,assign) int maxCountOfLine; //分割线的最大条数（不宜太大）
@property (nonatomic ,assign) int minCountOfLine;

@property (nonatomic ,strong)NSString *maxValueString;//展示数据中的最小值
@property (nonatomic ,strong)NSString *minValueString;//展示数据中的最大值
@property (nonatomic ,assign)float separaDistance;//每条分割线的Y坐标距离
@property (nonatomic ,assign)BOOL isDigitaloption;


-(void)initProperty;


@end
