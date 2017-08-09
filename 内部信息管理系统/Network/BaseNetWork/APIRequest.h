//
//  BaseAPIManager.h
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProxy.h"

@class APIRequest;
/*---------------------API回调-----------------------*/
@protocol APIManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(APIRequest *)request;
- (void)managerCallAPIDidFailed:(APIRequest *)request;
@end

/*---------------------API参数-----------------------*/
@protocol APIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApi:(APIRequest *)request;
@optional
- (void (^)(id <AFMultipartFormData> formData))uploadBlock:(APIRequest *)request;
@end

/*---------------------API验证器-----------------------*/
@protocol APIManagerValidator <NSObject>
@required
- (BOOL)manager:(APIRequest *)request isCorrectWithCallBackData:(BaseResponse *)data;
@end

/*---------------------APIManager-----------------------*/

@protocol APIManager <NSObject>
@optional
- (Class)responseClass;
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;
- (NSDictionary *)reformParamsForApi:(NSDictionary *)params;
- (void)reformData;
@required
- (NSString *)requestPath;
- (APIManagerRequestType)requestType;

@end

@interface APIRequest : NSObject
@property (nonatomic, weak) id<APIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<APIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<APIManagerValidator> validator;
@property (nonatomic, weak) id<APIManager> child;
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, strong) BaseResponse *responseData;
@property (nonatomic, assign, readonly)APIManagerErrorType errorType;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL disableErrorTip;
-(instancetype)initWithDelegate:(id)delegate paramSource:(id)paramSource;
- (NSInteger)loadDataWithHUDOnView:(UIView *)view;
- (NSInteger)loadDataWithHUDOnView:(UIView *)view HUDMsg:(NSString *)HUDMsg;
- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;
@end
