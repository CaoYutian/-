//
//  BaseTableViewDataSource.m
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import "BaseTableViewDataSource.h"

@interface BaseTableViewDataSource ()
@property(nonatomic, copy) NSString *cellIdentifier;
@property(nonatomic, strong) CellConfigureBlock cellConfigureBlock;
@end

@implementation BaseTableViewDataSource

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    self = [super init];
    if (self) {
        _items = items;
        _cellIdentifier = cellIdentifier;
        _cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    self = [super init];
    if (self) {
        _cellIdentifier = cellIdentifier;
        _cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return _items[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    if (_cellConfigureBlock) {
        id item = [self itemAtIndexPath:indexPath];
        _cellConfigureBlock(cell, item, indexPath);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)setItems:(NSArray *)items {
    _items = items;
}

@end
