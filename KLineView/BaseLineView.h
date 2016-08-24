//
//  BaseLineView.h
//  fenshiDemo
//
//  Created by qikai on 16/6/14.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLineView : UIScrollView
/**
 *  实现的功能是绘制白框，横纵坐标以及对应的分割线和刻度
 */
@property (nonatomic ,strong)NSArray *showDataArr;//展示出来的数据w
@property (nonatomic ,assign)NSInteger showCount; //展示出来的数量
@property (nonatomic ,strong)NSArray *allDataArr; //缓存起来的所有的数据
@property (nonatomic ,assign)NSInteger middleNumber; //用于表示中间那个item在allDataArr里面的位置


@property (nonatomic ,strong)UIColor *separaLineColor;//分割线的颜色
@property (nonatomic ,strong)UIColor *bigRectColor; //边框的颜色
@property (nonatomic ,strong)UIColor *coordingYColor;//Y坐标text的颜色
@property (nonatomic ,strong)UIColor *separaTextColor ; //刻度标尺的颜色

@property (nonatomic ,assign)int decimalNum;//保留到小数点后多少位

@property(assign, nonatomic) CGFloat axisMarginLeft;//绘制区域的left
@property(assign, nonatomic) CGFloat axisMarginBottom;
@property(assign, nonatomic) CGFloat axisMarginTop;
@property(assign, nonatomic) CGFloat axisMarginRight;

@property(assign, nonatomic) int fontNum;//字体大小

@property (nonatomic ,assign) int maxCountOfLine; //分割线的最大条数（不宜太大）
@property (nonatomic ,assign) int minCountOfLine; //分割线最小的条数（默认为5）

@property (nonatomic ,strong)NSString *maxValueString;//展示数据中的最小值
@property (nonatomic ,strong)NSString *minValueString;//展示数据中的最大值

@property (nonatomic ,assign)float separaDistance;//每条分割线的Y坐标距离
@property (nonatomic ,assign)BOOL isDigitaloption;//用于判断是否是二元交易
@property (nonatomic ,assign)double firstItemLoacationX;//最左侧的item相对于最初始位置偏移的位置,在进行滑动的时候可以通过改变这个item来改变视图的滑动效果
@property (nonatomic ,assign)double firstItemOffSetX;
@property (nonatomic ,assign)double firstItemX; //最左侧的item的位置
@property (nonatomic ,assign)double separaXWidth; // X轴分割线的宽度
@property (nonatomic ,assign)NSInteger bestRightItemNum; //最右侧的Item在allDataArr里面的num
@property (nonatomic ,assign)double lastSaveLocationX;
@property (nonatomic ,assign)int numofLine;


/**
 *  初始化设置
 */
-(void)initProperty;


@end
