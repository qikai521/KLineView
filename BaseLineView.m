//
//  BaseLineView.m
//  fenshiDemo
//
//  Created by qikai on 16/6/14.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "BaseLineView.h"

@implementation BaseLineView

{
    float _chaValue;
    int _numofLine;
}

//在未设置的时候初始化颜色以及绘制区域
-(void)initProperty
{
    self.separaLineColor = [UIColor grayColor];
//    self.coordingYColor = [UIColor blackColor];
    self.axisMarginRight = 5*8+10;
    self.fontNum = 10;
    self.axisMarginTop = 10;
    self.axisMarginBottom = 10;
    //初始化大条数和最小条数
    self.minCountOfLine = 6;
    self.maxCountOfLine = 12;
    
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
                _maxValueString = [self backValueStringWithNSString:showDataArr[i][@"buyData"] WithBool:YES];
                _minValueString = [self backValueStringWithNSString:showDataArr[i][@"sellData"] WithBool:NO];
            }else{
                if ([showDataArr[i][@"buyData"] floatValue] > [_maxValueString floatValue]) {
                    _maxValueString = [self backValueStringWithNSString:showDataArr[i][@"buyData"] WithBool:YES];
                }
                if ([showDataArr[i][@"sellData"] floatValue] < [_minValueString floatValue]) {
                    _minValueString = [self backValueStringWithNSString:showDataArr[i][@"sellData"] WithBool:NO];
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
    [self calculateYCoording];
}
#pragma mark 计算Y坐标刻度，并且绘制虚线
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
    for (int i = 0;  i < numofLine; i ++) {
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
    for (int i = 0 ; i < numofLine; i++) {
        CGFloat separaLineLenght = (self.frame.size.height - self.axisMarginTop - self.axisMarginBottom) / numofLine;
        CGContextSetLineWidth(context, 1);
        CGFloat length[2] = {2,2};
        CGContextSetLineDash(context, 0, length, 1);
        CGContextSetStrokeColorWithColor(context, self.separaLineColor.CGColor);
        CGContextMoveToPoint(context, self.axisMarginLeft , self.axisMarginTop + separaLineLenght * i);
        CGContextAddLineToPoint(context, self.frame.size.width - self.axisMarginLeft - self.axisMarginRight, self.axisMarginTop + separaLineLenght * i);
        CGContextStrokePath(context);
        CGContextSetLineDash(context, 0, nil, 0);
        
        NSString *drawText = textArr[numofLine - i - 1];
        [drawText drawInRect:CGRectMake(self.frame.size.width - self.axisMarginRight, self.axisMarginTop + separaLineLenght * i - _fontNum/2.0, drawText.length * _fontNum, _fontNum) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:_fontNum]}];
        
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


@end
