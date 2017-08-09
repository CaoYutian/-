//
//  BaseTableViewDelegate.h
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^CellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef void (^ScrollViewDidScrollBlock)(UITableView *tableView);
typedef NSArray * (^EditActionsForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

@interface BaseTableViewDelegate : NSObject <UITableViewDelegate>

@property(nonatomic, copy) CellHeightBlock cellHeightBlock;
@property(nonatomic, copy) CellSelectBlock cellSelectBlock;
@property(nonatomic, copy) ScrollViewDidScrollBlock scrollViewDidScrollBlock;
@property(nonatomic, copy  ) EditActionsForRowAtIndexPath editActionsForRowAtIndexPath;

@property(nonatomic, assign)BOOL clearSeperatorInset;

@end
