//
//  HttpTools.h
//  LaundrySheet
//
//  Created by 宇玄丶 on 2017/4/26.
//  Copyright © 2017年 MoShi_Mo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^zdSuccessBlock)(id responseObject);
typedef void (^zdFailureBlock)(NSError* error);


@interface HttpTools : NSObject

+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**带图片的post请求*/
+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
     imgData:(NSData *)imgData
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSDictionary *)signatureParams:(NSDictionary *)params;

@end
