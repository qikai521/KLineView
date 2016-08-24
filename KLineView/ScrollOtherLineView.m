//
//  ScrollOtherLineView.m
//  KLineView
//
//  Created by qikai on 16/8/22.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "ScrollOtherLineView.h"
#define  kCoodXSpace ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) + 10)/7.0

@implementation ScrollOtherLineView

-(void)initProperty{
    [super initProperty];
    self.delegate = self;
    self.userInteractionEnabled = YES;
    [self addZoomGestureRecognizer];
}
/**
 *  通过控制滑动的位置来操作showData的数据
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static NSInteger numOfLastItemNum = 0;
    self.firstItemLoacationX = scrollView.contentOffset.x;
    self.bestRightItemNum = self.allDataArr.count - (int)((scrollView.contentOffset.x + self.frame.size.width -self.axisMarginLeft - self.axisMarginRight + 10) /self.separaXWidth);
    if (self.bestRightItemNum < 0 ) {
        self.bestRightItemNum = 0;
    };
    self.middleNumber = self.bestRightItemNum + (int)self.showCount/2;
    if (self.bestRightItemNum < self.allDataArr.count - self.showDataArr.count && self.bestRightItemNum >= 0) {
        self.showDataArr = [self.allDataArr subarrayWithRange:NSMakeRange(self.bestRightItemNum, self.showCount)];
        //可以在这里改变FirstItem的Location
    }else{
        //加载数据
        
        self.lastSaveLocationX = 100 *self.separaXWidth;
        if (self.contentOffset.x == 0) {
            self.block(YES);
        }else{
            NSLog(@"不相等");
        }
    }
}
//设置scrollView的contentSize
-(void)setSeparaXWidth:(double)separaXWidth{
    [super setSeparaXWidth:separaXWidth];
    [self setContentOffset:CGPointMake(self.allDataArr.count * self.separaXWidth -self.frame.size.width+self.axisMarginLeft+self.axisMarginRight, 0)];
    self.firstItemLoacationX = self.contentOffset.x ;
    [self setContentSize:CGSizeMake(self.allDataArr.count * self.separaXWidth + self.axisMarginRight, self.frame.size.height)];
    [self setNeedsDisplay];
}

-(void)setUpdataBlockWithBlock:(UpdataMoreDataBlock )block{
    self.block = block;
}
/**
 *  添加放大缩小的手势识别
 */
-(void)addZoomGestureRecognizer{
    self.pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomBegin:)];
    self.pinch.delegate = self;
    [self addGestureRecognizer:self.pinch];
}
-(void)zoomBegin:(UIPinchGestureRecognizer *)pinch{
    int pinchNum = pinch.scale *100;
    NSLog(@"%d",pinchNum);
    if (pinch.scale > 1) {
        //放大
//        if (pinchNum % 1 == 0) {
            self.showCount  = self.showCount - 8;
//        }
    }else{
//        if (pinchNum % 3 == 0) {
            self.showCount  = self.showCount + 8;
//        }
    }
}

@end
