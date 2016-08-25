//
//  BaseModel.m
//  KLineView
//
//  Created by qikai on 16/7/28.
//  Copyright © 2016年 qikai. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel


- (instancetype)initWithDataDic:(NSDictionary *)infoDic
{
    self = [super init];
    if (self) {
        [self changePropertyWithInfoDic:infoDic];
    }
    return self;
}

//因为是根据infoDic里面的名字设置的成员变量
-(void )changePropertyWithInfoDic:(NSDictionary *)infoDic
{
    NSArray *propertyNames = [infoDic allKeys];
    for (NSString *propertyName in propertyNames) {
        //创建对应的property
        id value = [infoDic valueForKey:propertyName];
        if ([value isKindOfClass:[NSNull class]]) {
            value = nil;
        }
        [self creatPropertysWithPropertyName:propertyName];
        //更改对应的property的set方法
        NSMutableString *selString =[NSMutableString stringWithString:[NSString stringWithFormat:@"set%@:",propertyName]];
        NSString *replaceString = [selString substringWithRange:NSMakeRange(3, 1)];
        [selString replaceCharactersInRange:NSMakeRange(3, 1) withString:replaceString.uppercaseString];
        SEL setMethod = NSSelectorFromString(selString);
        if ([self respondsToSelector:setMethod]) {
            [self performSelector:setMethod withObject:value];
        }
        NSLog(@"haha");
    }
}

                                              
-(void)creatPropertysWithPropertyName:(NSString *)propertyName{
    
 }


@end
