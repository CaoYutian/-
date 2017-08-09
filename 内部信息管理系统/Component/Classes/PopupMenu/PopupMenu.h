//
//  PopupMenu.h
//  ANT_NZSELLER
//
//  Created by KevinCao on 2016/12/5.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CellSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface PopupMenu : UIView
@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)NSInteger maxRowCount;
@property(nonatomic, copy)CellSelectBlock cellSelectBlock;
-(void)show;
@end
