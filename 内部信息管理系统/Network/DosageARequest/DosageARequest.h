//
//  DosageARequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"

@interface DosageARequest : APIRequest <APIManager>

@end

@interface DosageAAllModel: NSObject

@property (nonatomic, strong) NSArray *need;
@property (nonatomic, strong) NSArray *data;

@end

@interface DosageAResponse : BaseResponse
@property (nonatomic, strong) DosageAAllModel *data;

@end
