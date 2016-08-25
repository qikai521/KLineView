//
//  ZhuLineView.m
//  KLineView
//
//  Created by qikai on 16/8/18.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "ZhuLineView.h"
#define  kCoodXSpace ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) + 10)/7.0
@interface ZhuLineView()

@property (nonatomic ,assign )double itemWidth; //每条柱状图的宽度为每个separarWidthX的2/3 ，两边的空白为1/3 ,没一侧的空白宽度为1/6


@end

@implementation ZhuLineView

-(void)initProperty{
    [super initProperty];
    self.candleUpColor = [UIColor zhuUpRectColor];
    self.candleDownColor = [UIColor zhuDownRectColor];
    self.candleLineColor = [UIColor zhuLinecolor];
#warning  -- 8.19 进行到现在
}

-(void)drawRect:(CGRect)rect{
    //调用父类的draw绘制底层的基本图
    [super drawRect:rect];
    //绘制K线对应的High low 直线
    [self drawHighLowChart];
    //绘制K线图
    [self drawCandlestickCharts];
    //重新绘制纵坐标
    [self reDrawCoodY];
}
/**
 *  绘制K线图，需要从右侧往左边绘制,需要根据先绘制根据showdatas的数量来绘制，首先需要绘制第一条数据，然后第一条线的位置跟初始位置和showdatas的数量还有偏移位置有关系
 */
-(void)drawCandlestickCharts{
    //首先绘制绿色的线框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.candleLineColor.CGColor);
    CGContextSetLineWidth(context, 2);
    for (int i = 0; i < self.showDataArr.count ; i++) {
        CGPoint leftTop = [self getLeftopPointWithItemNum:i];
        CGSize size = [self getitemSizeWithItemNum:i];
        CGContextAddRect(context, CGRectMake(leftTop.x, leftTop.y, size.width, size.height));
    }
    CGContextFillPath(context);
    for (int i = 0; i < self.showDataArr.count ; i++) {
        if ([self.showDataArr[i][@"open"] doubleValue] >  [self.showDataArr[i][@"close"] doubleValue]) {
            CGContextSetFillColorWithColor(context, self.candleDownColor.CGColor);
        }else{
            CGContextSetFillColorWithColor(context, self.candleUpColor.CGColor);
        }
        CGPoint leftTop = [self getLeftopPointWithItemNum:i];
        CGSize size = [self getitemSizeWithItemNum:i];
        CGContextAddRect(context, CGRectMake(leftTop.x + 1, leftTop.y +1, size.width-2, size.height-2));
        CGContextFillPath(context);
    }
}
/**
 *  根据item的num号来获取所得到的左上角的坐标位置
 */
-(CGPoint )getLeftopPointWithItemNum:(int )itemNum{

    double pointX = self.firstItemX - itemNum * self.separaXWidth -_itemWidth/2.0;

    double pointY = 0;
    if ([self.showDataArr[itemNum][@"open"] doubleValue] > [self.showDataArr[itemNum][@"close"] doubleValue]) {
        pointY = [self getCoodYValueWithDoubleValue:[self.showDataArr[itemNum][@"open"] doubleValue]];
    }else{
        pointY =[self getCoodYValueWithDoubleValue:[self.showDataArr[itemNum][@"close"] doubleValue]];
    }
    return CGPointMake(pointX, pointY);
}
-(CGSize )getitemSizeWithItemNum:(int )itemNum{
    double width = self.itemWidth;
    double height = [self getCoodYValueWithDoubleValue:[self.showDataArr[itemNum][@"open"] doubleValue]] - [self getCoodYValueWithDoubleValue:[self.showDataArr[itemNum][@"close"] doubleValue]];
    return CGSizeMake(width, ABS(height));
}
/**
 *  绘制K线对应的high low 图
 */
-(void)drawHighLowChart{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.candleLineColor.CGColor);
    for (int i = 0 ; i < self.showDataArr.count ; i++) {
        //开盘价格大约收盘价格   价格下跌
        CGPoint highPoint = [self getHightLowPointWithItem:i WithHighBool:YES];
        CGPoint lowPoint = [self getHightLowPointWithItem:i WithHighBool:NO];
        CGContextMoveToPoint(context, highPoint.x, highPoint.y);
        CGContextAddLineToPoint(context, lowPoint.x, lowPoint.y);
    }
    CGContextStrokePath(context);
}
-(CGPoint )getHightLowPointWithItem:(int )itemNum WithHighBool:(BOOL)isHigh{
    double pointX = self.firstItemX - itemNum * self.separaXWidth;
    double pointY = 0;
    if (isHigh == YES) {
        pointY = [self getCoodYValueWithDoubleValue:[self.showDataArr[itemNum][@"high"] doubleValue]];
    }else{
        pointY = [self getCoodYValueWithDoubleValue:[self.showDataArr[itemNum][@"low"] doubleValue]];
    }
    return CGPointMake(pointX, pointY);
}

/**
 *  当缩放的时候，改变separWidth的时候itemWidth也自动的改变
 */
-(void)setSeparaXWidth:(double)separaXWidth{
    [super setSeparaXWidth:separaXWidth];
    self.itemWidth = (separaXWidth *2) /3.0;
}

-(double )getCoodYValueWithDoubleValue:(double )doubleValue{
    float drawHeight = self.frame.size.height - self.axisMarginBottom - self.axisMarginTop;
    //获得Y值的最大值 最小值
    float minValueForY = [self.minValueString doubleValue] - self.separaDistance;
    float maxValueForY = [self.maxValueString doubleValue] + self.separaDistance;
    //时间X的最大值最小值
    float pointY = drawHeight - (doubleValue - minValueForY)*((drawHeight)/(maxValueForY - minValueForY));
    return pointY;
    
}

/**
 *  重新绘制纵坐标进行绘制
 */
-(void)reDrawCoodY{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextAddRect(context, CGRectMake( + self.firstItemLoacationX +self.frame.size.width - self.axisMarginRight+1, self.axisMarginTop,self.axisMarginRight-1, self.frame.size.height - self.axisMarginTop - self.axisMarginBottom));
    CGContextFillPath(context);
    
    NSMutableArray *textArr = [NSMutableArray array];
    double addToArrValue  = 0;
    NSInteger addToArrValueInterger = 0;
    for (int i = 0;  i < self.numofLine; i ++) {
        if (i == 0) {
            if (self.decimalNum == 0) {
                addToArrValueInterger = [self.minValueString integerValue];
            }else{
                addToArrValue = [self.minValueString doubleValue] ;
            }
        }else{
            addToArrValueInterger = addToArrValueInterger +[self getCoordYValue];
            addToArrValue = addToArrValue + [self getCoordYValue];
        }
        //将float转成字符串类型
        if (self.decimalNum == 0) {
            [textArr addObject:[NSString stringWithFormat:@"%ld",addToArrValueInterger]];
        }else{
            NSString *addString  = [NSString stringWithFormat:@"%f",addToArrValue];
            NSRange range = [addString rangeOfString:@"."];
            addString = [addString substringToIndex:range.location + range.length + self.decimalNum];
            [textArr addObject:addString];
        }
    }
    CGFloat separaLineLenght = (self.frame.size.height - self.axisMarginTop - self.axisMarginBottom) / self.numofLine;
    for (int i = 0; i <self.numofLine; i++) {
        NSString *drawText = textArr[self.numofLine - i - 1];
        [drawText drawInRect:CGRectMake(self.frame.size.width - self.axisMarginRight + 2 +self.firstItemLoacationX, self.axisMarginTop + separaLineLenght * i - self.fontNum/2.0, drawText.length * self.fontNum, self.fontNum) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:self.fontNum],NSForegroundColorAttributeName:self.separaTextColor}];
    }
    
}

-(float )getCoordYValue{
    int baseMultipe = 5;
    float baseCoord = 1/pow(10, self.decimalNum);
    float addValue = 0;
    do {
        addValue = baseCoord * baseMultipe;
        baseMultipe +=5;
    } while ([self.minValueString floatValue] - (addValue) + self.maxCountOfLine*addValue < [self.maxValueString floatValue] + (addValue));
    // 现在跳出的addVale是10条线内可以超越maxValue   然后选择一个最优化的解
    if ([self.minValueString floatValue] + (self.minCountOfLine ) *addValue > [self.maxValueString floatValue]) {
        if (self.minValueString != nil) {
            NSLog(@"5条之内就可以超出");
            self.numofLine = self.minCountOfLine;
        }
    }else{
        int i = self.minCountOfLine -1;
        do {
            i++;
        } while ([self.minValueString floatValue] + (i) *addValue < [self.maxValueString floatValue]);
        self.numofLine = i;
    }
    
    return addValue;
}


@end
