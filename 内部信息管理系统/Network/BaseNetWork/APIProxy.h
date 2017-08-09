//
//  APIProxy.h
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIResponse.h"

typedef NS_ENUM (NSUInteger, APIManagerRequestType){
    APIManagerRequestTypeGet,
    APIManagerRequestTypePost,
    APIManagerRequestTypeUpload,
    APIManagerRequestTypeDelete,
    APIManagerRequestTypePut
};

typedef void(^APICallback)(APIResponse *response);

@interface APIProxy : NSObject

@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer;
@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * responseSerializer;

+ (instancetype)sharedInstance;

- (NSInteger)callAPIWithRequestType:(APIManagerRequestType)requestType params:(NSDictionary *)params requestPath:(NSString *)requestPath uploadBlock:(void (^)(id <AFMultipartFormData> formData))uploadBlock success:(APICallback)success fail:(APICallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
