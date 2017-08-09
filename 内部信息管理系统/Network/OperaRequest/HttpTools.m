//
//  HttpTools.m
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/4/26.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import "HttpTools.h"

@implementation HttpTools

+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = \
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager POST:[NSString stringWithFormat:@"%@%@",Service_Address,urlString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

/**带图片的post请求*/
+ (void)POST:(NSString *)urlString
 parameters:(id)parameters
    imgData:(NSData *)imgData
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = \
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *fileName = [NSString stringWithFormat:@"%ld%c%c.jpg", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,urlString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (imgData) {
            [formData appendPartWithFileData:imgData name:@"imgurl" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
            DLog(@"%@",[NSString stringWithFormat:@"%@%@%@",Service_Address, urlString, responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (NSDictionary *)signatureParams:(NSDictionary *)params {
    if (![params isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    //获取token
    NSString *user_token = [UserManager sharedInstance].userData.user_token;
    if (CYTStringIsEmpty(user_token)) {
        user_token = @"-1";
    }
    
    NSMutableDictionary *signParams = [[NSMutableDictionary alloc] init];
    [signParams addEntriesFromDictionary:params];
    signParams[@"token"] = user_token;
    
    NSString *str2 = [self stringWithDict:signParams];
    
    NSString *sign = [CommonUtils MD5:str2];
    NSString *signature = [sign uppercaseString];
    NSMutableDictionary *newParams = [params mutableCopy];
    newParams[@"sign"] = signature;
    newParams[@"token"] = user_token;
    return newParams;
}

#pragma mark 参数按Key排序
-(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    NSString*str =@"";
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        if([value isKindOfClass:[NSDictionary class]]) {
            value = [self stringWithDict:value];
        }
        
        if([str length] !=0) {
            str = [str stringByAppendingString:@"&"];
        }
        
        str = [str stringByAppendingFormat:@"%@=%@",categoryId,value];
    }
    NSString *Str = [NSString stringWithFormat:@"%@%@",str,@"&key=appsecret"];
    return Str;
}

@end
