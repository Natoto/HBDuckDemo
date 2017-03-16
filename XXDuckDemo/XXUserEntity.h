//
//  XXUserEntity.h
//  XXDuckDemo
//
//  Created by sunnyxx on 14-8-27.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

@protocol HBDuckEntity;

@protocol XXSubUserEntity <NSObject>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) NSNumber *age; // 要用基本类型需要实现自动拆装箱
@property (nonatomic, strong) NSString * other;

@end

// 无需实体类，只需要协议
@protocol XXUserEntity <NSObject>
@property (nonatomic, strong) id<XXSubUserEntity,HBDuckEntity>  subuser;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) NSNumber *age; // 要用基本类型需要实现自动拆装箱
@property (nonatomic, strong) NSString * other;

@end
