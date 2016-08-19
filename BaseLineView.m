//
//  BaseLineView.m
//  fenshiDemo
//
//  Created by qikai on 16/6/14.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "BaseLineView.h"
#define  kShowCountMax 126//显示的最多的条数
#define  kShowCountMini 8 //显示的最小的条数,虚线的条数
#define  kCoodXSpace ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) + 10)/7.0

@implementation BaseLineView

{
    float _chaValue;
    int _numofLine;  //纵坐标的数量
    int _numOfItemOneX;//每一个格子可以有多少条数据
}

//在未设置的时候初始化颜色以及绘制区域
-(void)initProperty
{
    self.separaLineColor = [UIColor grayColor];
//    self.coordingYColor = [UIColor blackColor];
    self.bigRectColor = [UIColor whiteColor];
    self.separaTextColor = [UIColor whiteColor];
    self.axisMarginRight = 5*8+10;
    self.fontNum = 10;
    self.axisMarginTop = 1;
    self.axisMarginBottom = 20;
    //初始化大条数和最小条数
    self.minCountOfLine = 6;
    self.maxCountOfLine = 12;
    //设置显示的条数
    self.middleNumber = 4;
    self.showCount = 8;
    
}

//当showData 改变的时候需要重新绘制
-(void)setShowDataArr:(NSArray *)showDataArr
{
    //计算纵坐标
    _showDataArr = showDataArr;
    //需要计算当前显示的数组的最大值和最小值
    for (int i = 0;  i < showDataArr.count; i++) {
        //首先计算最大值(最大值只可能存在于sellData里面)
        if (self.isDigitaloption == NO) {
            //如果是普通的话
            if (i == 0 ) {
                _maxValueString = [self backValueStringWithNSString:showDataArr[i][@"high"] WithBool:YES];
                _minValueString = [self backValueStringWithNSString:showDataArr[i][@"low"] WithBool:NO];
            }else{
                if ([showDataArr[i][@"high"] floatValue] > [_maxValueString floatValue]) {
                    _maxValueString = [self backValueStringWithNSString:showDataArr[i][@"high"] WithBool:YES];
                }
                if ([showDataArr[i][@"low"] floatValue] < [_minValueString floatValue]) {
                    _minValueString = [self backValueStringWithNSString:showDataArr[i][@"low"] WithBool:NO];
                }
            }

        }else{
            //如果是二元的交易
            if (i == 0) {
                _maxValueString = [self backValueStringWithNSString:showDataArr[i][@"nowPrice"] WithBool:YES];
                _minValueString = [self backValueStringWithNSString:showDataArr[i][@"nowPrice"] WithBool:NO];
            }else{
                if ([showDataArr[i][@"nowPrice"] floatValue] > [_maxValueString floatValue]) {
                    _maxValueString = [self backValueStringWithNSString:showDataArr[i][@"nowPrice"] WithBool:YES];
                }
                if ([showDataArr[i][@"nowPrice"] floatValue] < [_minValueString floatValue]) {
                    _minValueString = [self backValueStringWithNSString:showDataArr[i][@"nowPrice"] WithBool:NO];
                }

            }
            
        }
    }
    
    if ([_maxValueString floatValue] - [_minValueString floatValue] > _chaValue) {
        _chaValue = [_maxValueString floatValue ] - [_minValueString floatValue];
        //如果有改变的话 重新计算Y坐标(6~ 10)之间
    }
}
//如果是isMax 那么就小数点后倒数第二位+1 如果不是就直接将最后一位置0
-(NSString *)backValueStringWithNSString:(NSString *)valueString
                                WithBool:(BOOL )isMax{
    if ([valueString isKindOfClass:[NSNumber class]]) {
        valueString = [NSString stringWithFormat:@"%@",valueString];
    }
    NSRange range = [valueString rangeOfString:@"."];
    //判断是否有.(1.23)
    NSInteger length = 0 ;
    if (range.location != NSNotFound) {
        length = range.location + self.decimalNum + 1;
    }else{
        return [NSString stringWithFormat:@"%ld",[valueString integerValue] + 1];
    }
    NSString *tempString = [valueString substringToIndex:length - 1];
    double finalDouble ;
    if (isMax) {
         finalDouble = [tempString doubleValue] + pow(0.1, self.decimalNum -1);
    }else{
         finalDouble = [tempString doubleValue] ;
    }
    NSString *finalString = [NSString stringWithFormat:@"%f",finalDouble];
    return [finalString substringToIndex:length];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self drawWhiteKuang];
    if (self.showDataArr.count == 0) {
        return;
    }
    //绘制纵坐标
    [self calculateYCoording];
    //绘制横坐标
    [self calculateXCoording];
}
/**
 *  绘制白框
 */
-(void)drawWhiteKuang{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(self.axisMarginLeft, self.axisMarginTop, self.frame.size.width - self.axisMarginLeft - self.axisMarginRight, self.frame.size.height - self.axisMarginTop - self.axisMarginBottom));
    CGContextSetStrokeColorWithColor(context, self.bigRectColor.CGColor);
    CGContextStrokePath(context);
}
#pragma mark 计算Y坐标刻度，并且绘制虚线
/**
 *  绘制总坐标虚线和对应的文字
 */
-(void)calculateYCoording{
    //最后一位必须是0,5的差别(只是后两位数变化即可)
    //线的数量要求在6~12之间
    //计算完成得到刻度的分割线为多少和一共有多少条线
    [self drawSeparaLineWithLineNum:_numofLine WithLineYCoord:[self getCoordYValue]];
    self.separaDistance = [self getCoordYValue];
}
#pragma  mark --根据刻度线的条数和刻度的间隔绘制分割线
-(void)drawSeparaLineWithLineNum:(int )numofLine WithLineYCoord:(float )ycoord{
    NSMutableArray *textArr = [NSMutableArray array];
    double addToArrValue  = 0;
    NSInteger addToArrValueInterger = 0;
    for (int i = 0;  i < _numofLine; i ++) {
        if (i == 0) {
            if (self.decimalNum == 0) {
                addToArrValueInterger = [_minValueString integerValue];
            }else{
                addToArrValue = [_minValueString doubleValue] ;
            }
        }else{
            addToArrValueInterger = addToArrValueInterger +ycoord;
            addToArrValue = addToArrValue + ycoord;
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0 ; i < _numofLine; i++) {
        CGFloat separaLineLenght = (self.frame.size.height - self.axisMarginTop - self.axisMarginBottom) / _numofLine;
        CGContextSetLineWidth(context, 1);
        CGFloat length[2] = {2,2};
        CGContextSetLineDash(context, 0, length, 1);
        CGContextSetStrokeColorWithColor(context, self.separaLineColor.CGColor);
        CGContextMoveToPoint(context, self.axisMarginLeft , self.axisMarginTop + separaLineLenght * i);
        CGContextAddLineToPoint(context, self.frame.size.width - self.axisMarginLeft - self.axisMarginRight, self.axisMarginTop + separaLineLenght * i);
        CGContextStrokePath(context);
        CGContextSetLineDash(context, 0, nil, 0);
        
        NSString *drawText = textArr[_numofLine - i - 1];
        [drawText drawInRect:CGRectMake(self.frame.size.width - self.axisMarginRight + 2, self.axisMarginTop + separaLineLenght * i - _fontNum/2.0, drawText.length * _fontNum, _fontNum) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:_fontNum],NSForegroundColorAttributeName:self.separaTextColor}];
        
    }
}
//获取纵坐标的刻度
-(float )getCoordYValue{
    int baseMultipe = 5;
    float baseCoord = 1/pow(10, self.decimalNum);
    float addValue = 0;
    do {
        addValue = baseCoord * baseMultipe;
        baseMultipe +=5;
    } while ([_minValueString floatValue] - (addValue) + self.maxCountOfLine*addValue < [_maxValueString floatValue] + (addValue));
    // 现在跳出的addVale是10条线内可以超越maxValue   然后选择一个最优化的解
    if ([_minValueString floatValue] + (self.minCountOfLine ) *addValue > [_maxValueString floatValue]) {
        if (_minValueString != nil) {
            NSLog(@"5条之内就可以超出");
            _numofLine = self.minCountOfLine;
        }
    }else{
        int i = self.minCountOfLine -1;
        do {
            i++;
        } while ([_minValueString floatValue] + (i) *addValue < [_maxValueString floatValue]);
        _numofLine = i;
    }
    
    return addValue;
}


#pragma mark --绘制横坐标和刻度
/**
 *  1.其横坐标的虚线需要从右往左绘制
 *  2.最初的样子应该是8条线每两条线是一个时间刻度
 *  3.虚线的位置相关的有1.初始位置，2.滑动的位置
 */
-(void)calculateXCoording{
    //首先计算出最右侧的线所在的位置
    double leftCoodX = self.frame.size.width - self.axisMarginRight +10 + (int)self.contentOffset.x%(int)kCoodXSpace;
    CGContextRef context = UIGraphicsGetCurrentContext();
#warning 使用addLines的方式 是否会使性能更加优化
    CGFloat length[2] = {2,2};
    CGContextSetLineDash(context, 0, length, 1);
    NSArray *timeTexts = [self getCoodXTextArray];
    for (int i = 0; i< 8 ; i ++) {
        double coodX = leftCoodX - kCoodXSpace * i;
        if (coodX >= self.axisMarginLeft && coodX <= self.frame.size.width - self.axisMarginRight) {
            CGContextMoveToPoint(context, coodX, self.axisMarginTop);
            CGContextAddLineToPoint(context, coodX, self.frame.size.height - self.axisMarginBottom);
            if ((i-1)%2 == 0) {
                NSString *drawText = [timeTexts objectAtIndex:i/2 ];
                [drawText drawAtPoint:CGPointMake(coodX, self.frame.size.height - self.axisMarginBottom + 1) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:_fontNum],NSForegroundColorAttributeName:self.separaTextColor}];
            }
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        }
    }
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}
/**
 *  获取time的text集合，是根据最右边是第一个的原理找到的
 *
 */
-(NSArray<NSString *> *)getCoodXTextArray{
    NSMutableArray *timeTextArr = [NSMutableArray array];
    for (int i = 0;  i < 4 ; i++) {
        //在showArr里面的index
        int showIndex = _numOfItemOneX * i *2 ;
        NSNumber *timeIntervalNumber = [self.showDataArr objectAtIndex:showIndex][@"timeInterval"];
        double timeIntevalDouble = [timeIntervalNumber doubleValue];
        NSDate *textDate = [NSDate dateWithTimeIntervalSince1970:timeIntevalDouble];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MM hh:mm"];
        NSString *dateString = [dateFormat stringFromDate:textDate];
        [timeTextArr addObject:dateString];
    }
    return timeTextArr;
}

#pragma mark --设置showCount时候调用的（在进行缩放的时候用的）
/**
 *  设置showCount的限制的max 和mini 之间
 *   showCount必须是2的n次方这样的数
 */
-(void)setShowCount:(NSInteger)showCount{
    if (_showCount != showCount) {
        _showCount = showCount;
        if (_showCount > kShowCountMax) {
            _showCount = kShowCountMax;
        }else if (_showCount < kShowCountMini){
            _showCount = kShowCountMini;
        }
        _numOfItemOneX = (int)_showCount/8;
        //修改可showCount那么需要修改showArray
        [self resetShowData];
    }
}
/**
 *  设置缩放的时候是以中间为基准的
 */
-(void)resetShowData{
    int nearShowCount = self.middleNumber - (int)self.showCount/2.0;
    id objc = _showDataArr[(int)(self.showCount/2.0)];
    self.middleNumber = [_allDataArr indexOfObject:objc];
    self.showDataArr = [_allDataArr subarrayWithRange:NSMakeRange(nearShowCount, self.showCount)];
    
}
#pragma mark --设置allData 的时候需要判断
-(void)setAllDataArr:(NSArray *)allDataArr{
    if (_allDataArr != allDataArr) {
        _allDataArr = allDataArr;
#warning  --需要根据最大的显示数量和每个k线所占的宽度计算scrollView的contenSize
    }
}




@end
