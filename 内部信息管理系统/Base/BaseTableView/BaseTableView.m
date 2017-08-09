//
//  BaseTableView.m
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import "BaseTableView.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "BaseTableViewCell.h"
#import "ViewHelper.h"
#import "MBProgressHUD.h"
#import "UIScrollView+EmptyDataSet.h"

#define CellReuseIdentifier @"Cell"

@interface BaseTableView() <APIManagerApiCallBackDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic, strong) BaseTableViewDataSource     *tableDataSource;
@property(nonatomic, strong) BaseTableViewDelegate       *tableDelegate;
@property(nonatomic, strong) MJRefreshNormalHeader       *comHeader;
@property(nonatomic, strong) MJRefreshAutoNormalFooter   *comFooter;

@property(nonatomic, strong) BaseTableViewCell       *cellHeight;      // 只创建一个cell用作测量高度
@property(nonatomic, strong) NSMutableDictionary     *cellHeightCache;  // 行高缓存

@end

@implementation BaseTableView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.dataSource = self.tableDataSource;
    self.delegate = self.tableDelegate;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    self.isShowEmptyTip = YES;
}

- (BaseTableViewDataSource *)tableDataSource {
    if (!_tableDataSource) {
        __weak typeof(self) weakSelf = self;
        _tableDataSource = [[BaseTableViewDataSource alloc] initWithCellIdentifier:CellReuseIdentifier cellConfigureBlock:^(UITableViewCell *cell, id item, NSIndexPath *indexPath) {
            if ([cell isKindOfClass:[BaseTableViewCell class]]) {
                BaseTableViewCell *comCell = (BaseTableViewCell *)cell;
                comCell.item = item;
                comCell.indexPath = indexPath;
                [comCell setCellData:item atIndexPath:indexPath];
            }
            if (weakSelf.cellConfigureBlock) {
                weakSelf.cellConfigureBlock(cell, item, indexPath);
            }
        }];
    }
    return _tableDataSource;
}

- (BaseTableViewDelegate *)tableDelegate {
    if (!_tableDelegate) {
        __weak typeof(self) weakSelf = self;
        _tableDelegate = [[BaseTableViewDelegate alloc] init];
        _tableDelegate.cellHeightBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            // 先取缓存
            if (weakSelf.isHeightCache && [weakSelf.cellHeightCache.allKeys containsObject:@(indexPath.row)]) {
                CGFloat height = [weakSelf.cellHeightCache[@(indexPath.row)] floatValue];
                return height;
            }
            
            CGFloat cellHeight = TableViewCellDefaultHeight;
            if (weakSelf.cellHeightBlock) {
                cellHeight = weakSelf.cellHeightBlock(tableView, indexPath);
            }
            else {
                if ([weakSelf.cellHeight isKindOfClass:[BaseTableViewCell class]]) {
                    if (weakSelf.dataArray.count) {
                        cellHeight = [weakSelf.cellHeight cellHeight:weakSelf.dataArray[indexPath.row] atIndexPath:indexPath];
                    } else {
                        cellHeight = [weakSelf.cellHeight cellHeight:weakSelf.pageRequest.listArray[indexPath.row] atIndexPath:indexPath];
                    }
                }
            }
            
            // 缓存height
            if (weakSelf.isHeightCache) {
                [weakSelf.cellHeightCache setObject:@(cellHeight) forKey:@(indexPath.row)];
            }
            
            return cellHeight;
        };
        _tableDelegate.cellSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.cellSelectBlock) {
                weakSelf.cellSelectBlock(tableView, indexPath);
            }
        };
        _tableDelegate.scrollViewDidScrollBlock = ^(UITableView *tableView) {
            if (weakSelf.scrollViewDidScrollBlock) {
                weakSelf.scrollViewDidScrollBlock(weakSelf);
            }
        };
        _tableDelegate.editActionsForRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
            if (weakSelf.editActionsForRowAtIndexPath) {
                return weakSelf.editActionsForRowAtIndexPath(tableView,indexPath);
            }
            return [NSArray array];
        };
    }
    return _tableDelegate;
}

- (MJRefreshNormalHeader *)comHeader {
    if (!_comHeader) {
        __weak typeof(self) weakSelf = self;
        _comHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (self.isHeightCache) {
                [self.cellHeightCache removeAllObjects];
            }
            if (self.headerWithRefreshingBlock) {
                self.headerWithRefreshingBlock();
            } else if (self.headerWithAdditionalRefreshingBlock) {
                self.headerWithAdditionalRefreshingBlock();
                [ErrorViewHelper removeErrorViewFromView:self.superview];
                self.pageRequest.moreData = NO;
                [weakSelf.pageRequest reload];
            } else {
                [ErrorViewHelper removeErrorViewFromView:self.superview];
                self.pageRequest.moreData = NO;
                [weakSelf.pageRequest reload];
            }
        }];
        [_comHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [_comHeader setTitle:@"释放更新" forState:MJRefreshStatePulling];
        [_comHeader setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        _comHeader.stateLabel.font = FONT_NORMAL;
        _comHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _comHeader;
}

- (MJRefreshAutoNormalFooter *)comFooter {
    if (!_comFooter) {
        __weak typeof(self) weakSelf = self;
        _comFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.pageRequest loadDataWithHUDOnView:nil];
        }];
        [_comFooter setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [_comFooter setTitle:@"加载中，请稍后..." forState:MJRefreshStateRefreshing];
        [_comFooter setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
        _comFooter.stateLabel.font = FONT_NORMAL;
    }
    return _comFooter;
}

- (void)managerCallAPIDidSuccess:(APIRequest *)manager
{
    [self loadSuccess];
}

- (void)managerCallAPIDidFailed:(APIRequest *)manager
{
    [self loadFail:manager.message];
}

- (void)setTableViewCellClass:(Class)tableViewCellClass {
    _tableViewCellClass = tableViewCellClass;
    [self registerClass:_tableViewCellClass forCellReuseIdentifier:CellReuseIdentifier];
    
    self.cellHeight = [self dequeueReusableCellWithIdentifier:CellReuseIdentifier];
}

- (void)setPageRequest:(PageAPIRequest *)pageRequest {
    if (_pageRequest == pageRequest) {
        return;
    }
    
    _pageRequest = pageRequest;
    self.tableDataSource.items = _pageRequest.listArray;
    self.isPaging = YES;
    self.isRefresh = YES;
    _pageRequest.delegate = self;
    
    [self loadDataFromServer];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    if (_dataArray == dataArray) {
        return;
    }
    if (self.isHeightCache) {
        [self.cellHeightCache removeAllObjects];
    }
    _dataArray = dataArray;
    self.tableDataSource.items = _dataArray;
}

-(void)setClearSeperatorInset:(BOOL)clearSeperatorInset
{
    self.tableDelegate.clearSeperatorInset = clearSeperatorInset;
}

- (void)setCellConfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    if (_cellConfigureBlock == cellConfigureBlock) {
        return;
    }
    _cellConfigureBlock = cellConfigureBlock;
    self.cellHeight.cellConfigureBlock = _cellConfigureBlock;
}

- (NSMutableDictionary *)cellHeightCache {
    if (!_cellHeightCache) {
        _cellHeightCache = [NSMutableDictionary dictionary];
    }
    return _cellHeightCache;
}

- (void)setIsHeightCache:(BOOL)isHeightCache {
    _isHeightCache = isHeightCache;
    if (_isHeightCache) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self.cellHeightCache
                                                 selector:@selector(removeAllObjects)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
}

- (void)reLoadDataFromServer {
    if (self.isHeightCache) {
        [self.cellHeightCache removeAllObjects];
    }
    UIView *hudSuperView = nil;
    if ([self viewController] && [[self viewController] isKindOfClass:[BaseViewController class]]) {
        BaseViewController *superVC = (BaseViewController *)[self viewController];
        hudSuperView = superVC.contentView;
    } else if (topMostViewController() && [topMostViewController() isKindOfClass:[BaseViewController class]]){
        hudSuperView = ((BaseViewController *)topMostViewController()).contentView;
    } else {
        hudSuperView = self.superview;
    }
    [self.pageRequest reloadOnView:hudSuperView];
}

- (void)loadDataFromServer {
    if (self.isHeightCache) {
        [self.cellHeightCache removeAllObjects];
    }
    self.mj_footer.hidden = (!self.pageRequest.moreData || self.contentSize.height<=self.height);
    UIView *hudSuperView = nil;
    if ([self viewController] && [[self viewController] isKindOfClass:[BaseViewController class]]) {
        BaseViewController *superVC = (BaseViewController *)[self viewController];
        hudSuperView = superVC.contentView;
    } else if (topMostViewController() && [topMostViewController() isKindOfClass:[BaseViewController class]]){
        hudSuperView = ((BaseViewController *)topMostViewController()).contentView;
    } else {
        hudSuperView = self.superview;
    }
    [self.pageRequest reloadOnView:hudSuperView];
}

- (void)loadFail:(NSString *)errorMsg {
    if (self.pageRequest.listArray.count == 0) {
        self.isShowErrorData = YES;
        self.isShowEmptyData = NO;
    }
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [self reloadData];
    if (self.requestFinishBlock) {
        self.requestFinishBlock(NO);
    }
    self.mj_footer.hidden = (!self.pageRequest.moreData || self.contentSize.height<=self.height);
}

- (void)loadSuccess {
    
    [ErrorViewHelper removeErrorViewFromView:self.superview];
    
    if (self.pageRequest.listArray.count == 0) {
        self.isShowEmptyData = YES;
        self.isShowErrorData = NO;
    }
    
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (!self.pageRequest.moreData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    [self reloadData];
    if (self.requestFinishBlock) {
        self.requestFinishBlock(YES);
    }
    self.mj_footer.hidden = (!self.pageRequest.moreData || self.contentSize.height<=self.height);
}

- (void)setIsPaging:(BOOL)isPaging {
    _isPaging = isPaging;
    self.mj_footer = _isPaging ? self.comFooter : nil;
    self.mj_footer.hidden = YES;
}

- (void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    self.mj_header = _isRefresh ? self.comHeader : nil;
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.noDataImgName) {
        return [UIImage imageNamed:self.noDataImgName];
    }
    return [UIImage imageNamed:@"empty"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"";
    if (self.isShowEmptyData) {
        text = self.noDataTitle?self.noDataTitle:@"亲，您暂时还没有任何内容哦~";
    } else if (self.isShowErrorData) {
        text = self.errorTitle?self.errorTitle:@"加载失败，点击重试";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.isShowEmptyTip && (self.isShowEmptyData || self.isShowErrorData);
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    if ([self.emptyDataDelegate respondsToSelector:@selector(verticalOffsetForEmptyDataSet:)]) {
        return [self.emptyDataDelegate verticalOffsetForEmptyDataSet:scrollView];
    }
    return -self.tableHeaderView.frame.size.height/2.0f;
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if ([self.emptyDataDelegate respondsToSelector:@selector(emptyDataSet:didTapView:)]) {
        [self.emptyDataDelegate emptyDataSet:scrollView didTapView:view];
    } else {
        [self buttonEvent];
    }
}

- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (self.isShowErrorData) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    if ([self.emptyDataDelegate respondsToSelector:@selector(buttonTitleForEmptyDataSet:forState:)]) {
        return [self.emptyDataDelegate buttonTitleForEmptyDataSet:scrollView forState:state];
    }
    return [[NSAttributedString alloc] initWithString:@""];
}

- (nullable UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if ([self.emptyDataDelegate respondsToSelector:@selector(buttonBackgroundImageForEmptyDataSet:forState:)]) {
        return [self.emptyDataDelegate buttonBackgroundImageForEmptyDataSet:scrollView forState:state];
    }
    return [[UIImage alloc] init];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    if ([self.emptyDataDelegate respondsToSelector:@selector(emptyDataSetDidTapButton:)]) {
        [self.emptyDataDelegate emptyDataSetDidTapButton:scrollView];
    }
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.emptyDataDelegate respondsToSelector:@selector(spaceHeightForEmptyDataSet:)]) {
        return [self.emptyDataDelegate spaceHeightForEmptyDataSet:scrollView];
    }
    return 20;
}

- (nullable UIColor *)borderColorForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.emptyDataDelegate respondsToSelector:@selector(borderColorForEmptyDataSet:)]) {
        return [self.emptyDataDelegate borderColorForEmptyDataSet:scrollView];
    }
    return MainBackgroundColor;
}

#pragma mark 按钮事件
- (void)buttonEvent {
    [self reLoadDataFromServer];
}

@end
