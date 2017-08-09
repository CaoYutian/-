//
//  BaseTableViewDataSource.h
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(UITableViewCell *cell, id data, NSIndexPath *indexPath);

@interface BaseTableViewDataSource : NSObject <UITableViewDataSource>

@property(nonatomic, strong) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

@end
