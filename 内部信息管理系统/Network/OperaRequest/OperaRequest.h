//
//  OperaRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/2.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"

@interface OperaRequest : APIRequest <APIManager>

@end

@interface OperaReponse : BaseResponse

@property (nonatomic, strong) NSDictionary *data;


@end
