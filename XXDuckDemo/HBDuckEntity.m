//
//  HBDuckEntity.m
//  XXDuckDemo
//
//  Created by sunnyxx on 14-8-16.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import "HBDuckEntity.h" 

@interface HBDuckEntity : NSProxy <HBDuckEntity>
@property (nonatomic, strong) NSMutableDictionary *innerDictionary;
@end

@implementation HBDuckEntity
@synthesize jsonString = _jsonString;

-(instancetype)init{
    
    return self;
}

- (instancetype)initWithJSONString:(NSString *)json
{
    if (json) {
        self->_jsonString = [json copy];
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            self.innerDictionary = [NSMutableDictionary  dictionaryWithDictionary:[jsonObject mutableCopy]];
        }
        return self;
    }
    return nil;
}


-(void)setInnerDictionary:(NSMutableDictionary *)innerDictionary{
    if (innerDictionary != _innerDictionary) {
        _innerDictionary = innerDictionary;
        [innerDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([[obj class] isSubclassOfClass:[NSDictionary class]]) {
                HBDuckEntity * subobj = HBDuckEntityCreateWithDictonary(obj);
                [_innerDictionary setObject:subobj forKey:key];
            }else if ([[obj class] isSubclassOfClass:[NSArray class]]) {
                NSArray * array = (NSArray *)obj;
                NSMutableArray * newarray = [NSMutableArray new];
                [array enumerateObjectsUsingBlock:^(NSDictionary * arrobj, NSUInteger idx2, BOOL * _Nonnull stop2) {
                    HBDuckEntity * arysubobj = HBDuckEntityCreateWithDictonary(arrobj);
                    [newarray addObject:arysubobj];
                }];
                [_innerDictionary setObject:newarray forKey:key];
            }
        }];
    }
}
#pragma mark - Message Forwading

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // Change method signature to NSMutableDictionary's
    // getter -> objectForKey:
    // setter -> setObject:forKey:

    SEL changedSelector = aSelector;
    
    if ([self propertyNameScanFromGetterSelector:aSelector]) {
        changedSelector = @selector(objectForKey:);
    }
    else if ([self propertyNameScanFromSetterSelector:aSelector]) {
        changedSelector = @selector(setObject:forKey:);
    }
    
    NSMethodSignature *sign = [[self.innerDictionary class] instanceMethodSignatureForSelector:changedSelector];

    return sign;
}

-(NSString *)description{
 
    return [NSString stringWithFormat:@"%@",self.innerDictionary];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *propertyName = nil;

    // Try getter
    propertyName = [self propertyNameScanFromGetterSelector:invocation.selector];
    if (propertyName) {
        invocation.selector = @selector(objectForKey:);
        [invocation setArgument:&propertyName atIndex:2]; // self, _cmd, key
        [invocation invokeWithTarget:self.innerDictionary];
        return;
    }
    
    // Try setter
    propertyName = [self propertyNameScanFromSetterSelector:invocation.selector];
    if (propertyName) {
        
        invocation.selector = @selector(setObject:forKey:);
        [invocation setArgument:&propertyName atIndex:3]; // self, _cmd, obj, key
        [invocation invokeWithTarget:self.innerDictionary];
        return;
    }
    @try {
        [super forwardInvocation:invocation];
    } @catch (NSException *exception) {
        NSLog(@"DUCK: 调用%@出错了",NSStringFromSelector(invocation.selector));
    } @finally {
        
    }
}

#pragma mark - Helpers

- (NSString *)propertyNameScanFromGetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    NSUInteger parameterCount = [[selectorName componentsSeparatedByString:@":"] count] - 1;
    if (parameterCount == 0) {
        return selectorName;
    }
    return nil;
}

- (NSString *)propertyNameScanFromSetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    NSUInteger parameterCount = [[selectorName componentsSeparatedByString:@":"] count] - 1;

    if ([selectorName hasPrefix:@"set"] && parameterCount == 1) {
        NSUInteger firstColonLocation = [selectorName rangeOfString:@":"].location;
        return [selectorName substringWithRange:NSMakeRange(3, firstColonLocation - 3)].lowercaseString;
    }
    return nil;
}

@end

id HBDuckEntityCreateWithJSON(NSString *json)
{
    return [[HBDuckEntity alloc] initWithJSONString:json];
}

id HBDuckEntityCreateWithDictonary(NSDictionary *dic)
{
    HBDuckEntity * entity = [[HBDuckEntity alloc] init];
    entity.innerDictionary = [dic mutableCopy];
    return  entity;
}
