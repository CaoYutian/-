//
//  PageAPIRequest.h
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/2.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import "APIRequest.h"

@protocol PageDelegate <NSObject>
@required
- (NSArray *)buildPageArray;
@end

@interface PageAPIRequest : APIRequest <APIManager>

/**
 *  当前页数
 */
@property (nonatomic, assign) NSUInteger                currentPage;
/**
 *  最终结果
 */
@property (nonatomic, strong) NSMutableArray*           listArray;
/**
 *  是否还有数据，只要有数据返回，就认为还有下一页
 */
@property (nonatomic, assign) BOOL                      moreData;

/**
 *  清空listArray，currentPage = 0
 */
- (void)reload;

/**
 *  清空listArray，currentPage = 1
 */
- (void)reloadOnView:(UIView *)view;

/**
 *  每页多少条数据，默认20
 */
@property(nonatomic,assign)NSInteger pageSize;

@end
