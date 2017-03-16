HBDuckDemo  json最强解析
==========
1. 利用nsproxy创建鸭子对象，一句话解析json
2. 面向protocol编程
3. 参考链接 [http://blog.sunnyxx.com/2014/08/24/objc-duck/]
4. 


```javascripte
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

```


