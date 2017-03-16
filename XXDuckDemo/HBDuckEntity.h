//
//  HBDuckEntity.h
//  XXDuckDemo
//
//  Created by sunnyxx on 14-8-16.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HBDuckEntity <NSObject>
@property (nonatomic, copy, readonly) NSString *jsonString;
@end

extern id/*<HBDuckEntity>*/ HBDuckEntityCreateWithJSON(NSString *json);
 
extern id HBDuckEntityCreateWithDictonary(NSDictionary *dic);
