//
//  DosageAModel.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DosageAModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *qz_id;
@property (nonatomic, copy) NSString *cj_date;
@property (nonatomic, copy) NSString *vl_tody;
@property (nonatomic, copy) NSString *vl;
@property (nonatomic, copy) NSString *t_yw;
@property (nonatomic, copy) NSString *vl_hour;
@property (nonatomic, copy) NSString *f_yw;
@property (nonatomic, copy) NSString *is_open;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *yugu_time;
@property (nonatomic, copy) NSString *parse_status;
@property (nonatomic, copy) NSString *big_buye;
@property (nonatomic, copy) NSString *curr_quality;
@property (nonatomic, copy) NSString *agv_vl;

@end

@interface dischargPlanModel : NSObject

@property (nonatomic, strong) NSArray *dischargDataArr;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *short_name;
@property (nonatomic, copy) NSString *qz_id;
@property (nonatomic, copy) NSString *cj_date;
@property (nonatomic, copy) NSString *vl_tody;
@property (nonatomic, copy) NSString *vl;
@property (nonatomic, copy) NSString *t_yw;
@property (nonatomic, copy) NSString *vl_hour;
@property (nonatomic, copy) NSString *f_yw;
@property (nonatomic, copy) NSString *is_open;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *yugu_time;
@property (nonatomic, copy) NSString *parse_status;
@property (nonatomic, copy) NSString *big_buye;
@property (nonatomic, copy) NSString *curr_quality;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;

@end
