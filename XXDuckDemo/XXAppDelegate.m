//
//  XXAppDelegate.m
//  XXDuckDemo
//
//  Created by sunnyxx on 14-8-27.
//  Copyright (c) 2014年 sunnyxx. All rights reserved.
//

#import "XXAppDelegate.h"
#import "HBDuckEntity.h"
#import "XXUserEntity.h"
#import "XXDIProxy.h"
#import "XXTestDIProtocolsAndImps.h"
#import "SMDProtocol.h"

@implementation XXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self demoJsonEntity];
    [self demoDependencyInjection];
    return YES;
}

- (void)demoJsonEntity
{
    NSString *json = @"{\"name\": \"sunnyxx\", \"sex\": \"boy\", \"age\": 24,\"subuser\":{\"name\":\"huangbo\"}}";
    id<HBDuckEntity, XXUserEntity> entity= HBDuckEntityCreateWithJSON(json);
    
    NSLog(@"%@, %@, %@", entity.jsonString, entity.name, entity.age);
    entity.name = @"east north";
    entity.age = @100;
    entity.other = @"aaaa";
    NSLog(@"%@",entity.subuser.name);  
    
    NSLog(@"%@, %@", entity.name, entity.age);

#pragma mark - json解析升级了 直接对应model
    
    NSString * filapath =[[NSBundle mainBundle] pathForResource:@"testjson" ofType:@"json"] ;
    NSData * data = [NSData dataWithContentsOfFile:filapath];
    NSString * json2 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     
    id<HBDuckEntity, SMDResponse> smdentity = HBDuckEntityCreateWithJSON(json2);
    NSLog(@"%@",smdentity.code);
    NSLog(@"%@",smdentity.message);
    NSLog(@"%@",smdentity.data.total);
    NSLog(@"%@",smdentity.data.data);
    NSLog(@"%@",smdentity.data);
    NSArray * array = smdentity.data.data;
    id<SMDRespDataData>  info = array[0];
    id<SMDRespDataAskerUser> askUser = info.askUser;
    id<SMDRespDataQaInfo> qainfo = info.qaInfo;
    NSLog(@"%@ %@ %@",info,askUser,qainfo);
    
    
}

- (void)demoDependencyInjection
{
    林志玲 *implementA = [林志玲 new];
    凤姐 *implementB = [凤姐 new];
    
    id<XXGirlFriend, XXDIProxy> proxy = XXDIProxyCreate();
    [proxy injectDependencyObject:implementA forProtocol:@protocol(XXGirlFriend)];
    [proxy kiss];
    
    
    [proxy injectDependencyObject:implementB forProtocol:@protocol(XXGirlFriend)];
    [proxy kiss];

}

@end
