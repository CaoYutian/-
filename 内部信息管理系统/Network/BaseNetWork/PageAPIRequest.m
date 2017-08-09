//
//  PageAPIRequest.m
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/2.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import "PageAPIRequest.h"

@implementation PageAPIRequest

- (id)init {
    self = [super init];
    if (self) {
        self.currentPage = 1;
        self.pageSize = 20;
    }
    return self;
}

- (id)initWithDelegate:(id)delegate paramSource:(id)paramSource {
    self = [super initWithDelegate:delegate paramSource:paramSource];
    if (self) {
        self.currentPage = 1;
        self.pageSize = 20;
    }
    return self;
}

- (NSDictionary *)reformParamsForApi:(NSDictionary *)params
{
    NSMutableDictionary *newParmas = params?[params mutableCopy]:[NSMutableDictionary dictionary];
    [newParmas setObject:[NSNumber numberWithInteger:self.currentPage] forKey:@"page"];
    [newParmas setObject:[NSNumber numberWithInteger:[self pageSize]] forKey:@"page_size"];
    [newParmas setObject:[NSNumber numberWithInteger:[self pageSize]] forKey:@"limit"];
    return newParmas;
}

- (void)reformData
{
    if (_currentPage == 1) {
        [self.listArray removeAllObjects];
    }
    
    NSArray *array = nil;
    if ([self.responseData respondsToSelector:@selector(buildPageArray)]) {
        array = [self.responseData performSelector:@selector(buildPageArray)];
    }
    self.moreData = NO;
    if ([array count] > 0) {
        self.moreData = [array count] >= [self pageSize] ? YES : NO;
        self.currentPage ++;
        [self.listArray addObjectsFromArray:array];
    }
}

- (void)reload {
    self.currentPage = 1;
    [self loadDataWithHUDOnView:nil];
}

- (void)reloadOnView:(UIView *)view
{
    self.currentPage = 1;
    [self loadDataWithHUDOnView:view];
}

- (NSString *)requestPath
{
    return [self.child requestPath];
}

- (APIManagerRequestType)requestType
{
    return [self.child requestType];
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
