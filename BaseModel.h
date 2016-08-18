//
//  BaseModel.h
//  KLineView
//
//  Created by qikai on 16/7/28.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

-(instancetype )initWithDataDic:(NSDictionary *)infoDic;

@property (nonatomic ,strong )NSString *name;
@end
