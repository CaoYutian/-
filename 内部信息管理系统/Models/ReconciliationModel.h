//
//  ReconciliationModel.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReconciliationModel : NSObject

@property (nonatomic, assign) BOOL select;

@property (nonatomic, copy) NSString *car_id;
@property (nonatomic, copy) NSString *data_gongqi;
@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *qz_id;
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *xcl;
@property (nonatomic, copy) NSString *ywwc;
@property (nonatomic, copy) NSString *gongqi_id;

@end
