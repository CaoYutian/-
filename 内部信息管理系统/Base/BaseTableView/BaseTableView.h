//
//  BaseTableView.h
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageAPIRequest.h"
#import "BaseTableViewDataSource.h"
#import "BaseTableViewDelegate.h"

typedef void (^HeaderWithRefreshingBlock)();
typedef void (^HeaderWithAdditionalRefreshingBlock)();
typedef void (^RequestFinishBlock)(BOOL status);

@protocol EmptyDataDeletgate <NSObject>

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView;

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView;

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view;

- (UIColor *)borderColorForEmptyDataSet:(UIScrollView *)scrollView;

@end

@interface BaseTableView : UITableView

@property(nonatomic, strong) PageAPIRequest*    pageRequest;
@property(nonatomic, strong) NSMutableArray*    dataArray;
@property(nonatomic, strong) Class              listModelClass;
@property(nonatomic, strong) Class              tableViewCellClass;
@property(nonatomic, copy  ) CellConfigureBlock cellConfigureBlock;
@property(nonatomic, copy  ) CellHeightBlock    cellHeightBlock;
@property(nonatomic, copy  ) CellSelectBlock    cellSelectBlock;
@property(nonatomic, copy  ) HeaderWithRefreshingBlock  headerWithRefreshingBlock;
@property(nonatomic, copy  ) HeaderWithAdditionalRefreshingBlock  headerWithAdditionalRefreshingBlock;
@property(nonatomic, copy  ) RequestFinishBlock  requestFinishBlock;
@property(nonatomic, copy) ScrollViewDidScrollBlock scrollViewDidScrollBlock;
@property(nonatomic, copy  ) EditActionsForRowAtIndexPath  editActionsForRowAtIndexPath;
@property(nonatomic, weak) id<EmptyDataDeletgate>emptyDataDelegate;

@property(nonatomic, assign) BOOL           isPaging;
@property(nonatomic, assign) BOOL           isRefresh;
@property(nonatomic, assign) BOOL           isShowEmptyTip;
@property(nonatomic, assign) BOOL           isHeightCache;
@property(nonatomic, assign) BOOL           clearSeperatorInset;
@property(nonatomic, assign) BOOL           isShowOrHiddenEmptyTip;

- (void)loadDataFromServer;
- (void)reLoadDataFromServer;
- (void)loadSuccess;
- (void)loadFail:(NSString *)errorMsg;


//是否显示空数据页面  默认为显示
@property(nonatomic,assign) BOOL isShowEmptyData;
@property(nonatomic,assign) BOOL isShowErrorData;

//空数据页面的title -- 可不传，默认为：暂无任何数据
@property(nonatomic,strong) NSString *noDataTitle;
//空数据页面的title -- 可不传，默认为：暂无任何数据
@property(nonatomic,strong) NSString *errorTitle;
//空数据页面的图片 -- 可不传，默认图片为：NoData
@property(nonatomic,strong) NSString *noDataImgName;

- (void)buttonEvent;

@end
