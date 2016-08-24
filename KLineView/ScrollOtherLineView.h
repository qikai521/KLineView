//
//  ScrollOtherLineView.h
//  KLineView
//
//  Created by qikai on 16/8/22.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "OtherLineView.h"
/**
 *  根据移动来重新绘制
 */
typedef void(^UpdataMoreDataBlock) (BOOL isAdd);
@interface ScrollOtherLineView : OtherLineView<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic ,strong )UIPinchGestureRecognizer *pinch;
@property (nonatomic ,strong )UpdataMoreDataBlock block;

-(void)setUpdataBlockWithBlock:(UpdataMoreDataBlock )block;
-(void)initProperty;

@end
