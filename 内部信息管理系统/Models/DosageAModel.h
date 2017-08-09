//
//  DosageAModel.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DosageAModel : NSObject

@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *all_name;
@property (nonatomic, copy) NSString *cj_date;
@property (nonatomic, copy) NSString *cz;
@property (nonatomic, copy) NSString *f_yw;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *is_open;
@property (nonatomic, copy) NSString *qz_id;
@property (nonatomic, copy) NSString *t_yw;
@property (nonatomic, copy) NSString *vl;
@property (nonatomic, copy) NSString *yw_change;

@end

@interface dischargPlanModel : NSObject

@property (nonatomic, copy) NSString *lngCar;
@property (nonatomic, copy) NSString *liquidSource;
@property (nonatomic, copy) NSString *address1;
@property (nonatomic, copy) NSString *address2;
@property (nonatomic, copy) NSString *address3;

@end
