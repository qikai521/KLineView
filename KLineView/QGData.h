//
//  QGData.h
//  KLineView
//
//  Created by qikai on 16/7/28.
//  Copyright © 2016年 qikai. All rights reserved.
//

//先从本地中获取数据，然后根据先将本地的数据添加到视图上面去，判断一下，如果获取的当前数据和本地数据有更新，或者是加载了之前的数据，就将

#import <Foundation/Foundation.h>

@interface QGData : NSObject
//持有的数据
@property (nonatomic , strong ) NSArray *allData;

@property (nonatomic , strong ) NSArray *showData;



@end
