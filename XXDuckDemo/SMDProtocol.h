//
//  SMDProtocol.h
//  XXDuckDemo
//
//  Created by boob on 17/3/16.
//  Copyright © 2017年 sunnyxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMDRespDataQaInfo <NSObject>
@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * answer;
@property (nonatomic, strong) NSString * duration;
@property (nonatomic, strong) NSNumber * listens;
@property (nonatomic, strong) NSNumber * status;
@property (nonatomic, strong) NSNumber * question_type;
@property (nonatomic, strong) NSString * question_type_name;
@property (nonatomic, strong) NSString * create_at;
@property (nonatomic, strong) NSString * update_at;
@property (nonatomic, strong) NSNumber * listen_free;

@end

@protocol SMDRespDataAskerUser <NSObject>
@property (nonatomic, strong) NSString * nick;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSNumber * answers;
@property (nonatomic, strong) NSNumber * last_page;
@property (nonatomic, strong) NSString * intro;
@property (nonatomic, strong) NSNumber * fans;
@property (nonatomic, strong) NSNumber * credit;
@property (nonatomic, strong) NSNumber * credit_free;
@property (nonatomic, strong) NSNumber * ban;
@property (nonatomic, strong) NSNumber * has_focus;
@property (nonatomic, strong) NSNumber * uid;
@end

@protocol SMDRespDataData <NSObject>
@property (nonatomic, strong) id<SMDRespDataAskerUser>  askUser;
@property (nonatomic, strong) id<SMDRespDataAskerUser>  answerUser;
@property (nonatomic, strong) id<SMDRespDataQaInfo> qaInfo;

@end


@protocol SMDResponseData <NSObject>
@property (nonatomic, strong) NSNumber * total;
@property (nonatomic, strong) NSNumber * per_page;
@property (nonatomic, strong) NSNumber * current_page;
@property (nonatomic, strong) NSNumber * last_page;
@property (nonatomic, strong) NSArray<SMDRespDataData>* data;
@end

@protocol SMDResponse <NSObject>
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) id<SMDResponseData>  data;

@end
