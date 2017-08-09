//
//  PopupMenu.m
//  ANT_NZSELLER
//
//  Created by KevinCao on 2016/12/5.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import "PopupMenu.h"
#import "BaseTableViewCell.h"

@interface PopupMenu () <UIGestureRecognizerDelegate>
//背景
@property(nonatomic,strong)UIView *bgView;
//菜单列表
@property(nonatomic,strong)BaseTableView *menuTableView;
@end

@implementation PopupMenu

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.maxRowCount = 5;
    }
    return self;
}

-(void)show
{
    if (!self.bgView.superview) {
        UIWindow *window = mainWindow();
        [window addSubview:self.bgView];
        if (!self.menuTableView.superview) {
            [self.bgView addSubview:self.menuTableView];
        }
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        }];
    }
    self.menuTableView.top = self.bgView.bottom;
    [UIView animateWithDuration:0.3 animations:^{
        self.menuTableView.top = self.bgView.bottom-self.menuTableView.height;
    }];
}

-(void)dismiss
{
    [self.bgView removeFromSuperview];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self.bgView];
    return !CGRectContainsPoint(self.menuTableView.frame, touchPoint);
}

#pragma mark - actions
-(void)tapAction
{
    [self dismiss];
}

#pragma mark - getters and setters
-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = [dataArray copy];
    if (_dataArray.count<self.maxRowCount) {
        self.menuTableView.height = _dataArray.count*TableViewCellDefaultHeight;
    } else {
        self.menuTableView.height = self.maxRowCount*TableViewCellDefaultHeight;
    }
    self.menuTableView.dataArray = dataArray;
}

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:mainWindow().bounds];
        _bgView.backgroundColor = COLOR_BG_COVER;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        tapGesture.delegate = self;
        [_bgView addGestureRecognizer:tapGesture];
    }
    return _bgView;
}

-(BaseTableView *)menuTableView
{
    if (!_menuTableView) {
        _menuTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, self.bgView.height-TableViewCellDefaultHeight*3, self.bgView.width, TableViewCellDefaultHeight*3)];
        _menuTableView.tableViewCellClass = [BaseTableViewCell class];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuTableView.bounces = NO;
        _menuTableView.cellConfigureBlock = ^ (UITableViewCell *cell, id data, NSIndexPath *indexPath) {
            cell.textLabel.font = FONT_NORMAL;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = data;
        };
        WS(weakSelf);
        _menuTableView.cellSelectBlock = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            [weakSelf dismiss];
            weakSelf.cellSelectBlock(tableView,indexPath);
        };
    }
    return _menuTableView;
}

@end
