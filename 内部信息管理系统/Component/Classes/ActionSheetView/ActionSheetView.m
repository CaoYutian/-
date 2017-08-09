//
//  ActionSheetView.m
//  YQW
//
//  Created by Sunshine on 2017/6/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ActionSheetView.h"

#define     TITLE_FONT_SIZE             13.0f
#define     BUTTON_FONT_SIZE            18.0f
#define     HEIGHT_BUTTON               48.0f
#define     SPACE_MIDDEL                8.0f
#define     SPACE_TITLE_LEFT            22.0f
#define     SPACE_TITLE_TOP             20.0f

#define     COLOR_BACKGROUND            [UIColor colorWithWhite:0.0 alpha:0.4]
#define     COLOR_DESTRUCTIVE_TITLE     [UIColor redColor]

@interface ActionSheetView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger tableViewButtonCount;
}

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *cancelButtonTitle;
@property(nonatomic,strong)NSString *destructiveButtonTitle;
@property(nonatomic,strong)NSMutableArray *otherButtonTitles;
@property(nonatomic,strong)UIButton *backgroudView;
@property(nonatomic,strong)UIView *actionSheetView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UILabel *headerTitleLabel;

@end

@implementation ActionSheetView

#pragma mark - block 初始化
- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtons actionSheetBlock:(ActionSheetViewBlock)actionSheetBlock {
    self = [super init];
    if (self) {
        
        [self setTitle:title];
        
        if (actionSheetBlock) {
            self.acitonSheetBlock = actionSheetBlock;
        }
        
        [self setCancelButtonTitle:cancelButtonTitle];
        [self setDestructiveButtonTitle:destructiveButtonTitle];
        
        if (otherButtons) {
            self.otherButtonTitles = [[NSMutableArray alloc] init];
            [self.otherButtonTitles addObjectsFromArray:otherButtons];
        }
        
        tableViewButtonCount = self.otherButtonTitles.count + (destructiveButtonTitle ? 1 : 0);
        _numberOfButtons = tableViewButtonCount + (cancelButtonTitle ? 1 : 0);
        _destructiveButtonIndex = (destructiveButtonTitle ? 0 : -1);
        _cancelButtonIndex = (self.cancelButtonTitle ? self.otherButtonTitles.count + (self.destructiveButtonTitle ? 1 : 0) : -1);
        
        [self setupActionSheetViewSubviews];
    }
    return self;
    
}

#pragma mark - private methods
- (void)setupActionSheetViewSubviews{
    [self setFrame:[UIScreen mainScreen].bounds];
    [self addSubview:self.backgroudView];
    [self addSubview:self.actionSheetView];
    [self.actionSheetView addSubview:self.tableView];
    [self.backgroudView setFrame:self.bounds];
    
    NSInteger bottomHeight = 0;
    NSInteger tableHeight = 0;
    if (self.cancelButtonTitle) {
        [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [self.cancelButton setFrame:CGRectMake(0, self.height - HEIGHT_BUTTON, self.width, HEIGHT_BUTTON)];
        [self.actionSheetView addSubview:self.cancelButton];
        
        bottomHeight += HEIGHT_BUTTON;
        tableHeight += SPACE_MIDDEL;
    }else {
        [self.cancelButton removeFromSuperview];
    }
    
    if (tableViewButtonCount * HEIGHT_BUTTON > self.frame.size.height - bottomHeight - 20) {
        tableHeight += (self.frame.size.height - bottomHeight - 20);
        [self.tableView setBounces:YES];
    }else {
        tableHeight += (tableViewButtonCount * HEIGHT_BUTTON);
        [self.tableView setBounces:NO];
    }
    
    if (self.title.length > 0) {
        [self.headerTitleLabel setFrame:CGRectMake(SPACE_TITLE_LEFT, SPACE_TITLE_TOP, self.width - SPACE_TITLE_LEFT * 2, 0)];
        [self.headerTitleLabel setText:self.title];
        CGFloat hightTitle = [self.headerTitleLabel sizeThatFits:CGSizeMake(self.headerTitleLabel.width, MAXFLOAT)].height;
        [self.headerTitleLabel setHeight:hightTitle];
        
        CGFloat hightHeader = hightTitle + SPACE_TITLE_TOP * 2;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, hightHeader)];
        [headerView setBackgroundColor:WHITECOLOR];
        [headerView addSubview:self.headerTitleLabel];
        
        if (self.destructiveButtonTitle || tableViewButtonCount > 0) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, hightHeader - 0.5, self.width, 0.5)];
            [lineView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.3]];
            [headerView addSubview:lineView];
        }
        
        [self.tableView setTableHeaderView:headerView];
        tableHeight += hightHeader;
    }
    
    [self.actionSheetView setFrame:CGRectMake(0, self.frame.size.height - bottomHeight - tableHeight, self.frame.size.width, bottomHeight + tableHeight)];
    [self.tableView setFrame:CGRectMake(0, 0, self.width, tableHeight)];
    [self.cancelButton setFrame:CGRectMake(0, tableHeight, self.width, HEIGHT_BUTTON)];
}

#pragma mark - 显示
- (void)show {
    [mainWindow() endEditing:YES];
    [self showInView:[UIApplication sharedApplication].delegate.window];
}

- (void)showInView:(UIView *)view {
    if (nil == view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    [view addSubview:self];
    CGRect rect = CGRectMake(0, self.height - self.actionSheetView.height, self.width, self.actionSheetView.height);
    [self.backgroudView setBackgroundColor:[UIColor clearColor]];
    [self.actionSheetView setOrigin:CGPointMake(0, self.height)];
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.actionSheetView setFrame:rect];
        [self.backgroudView setBackgroundColor:COLOR_BACKGROUND];
    }];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex {
    buttonIndex -= self.destructiveButtonTitle ? 1 : 0;
    if (-1 == buttonIndex) {
        return self.destructiveButtonTitle;
    }else if (buttonIndex >= 0 && buttonIndex < self.otherButtonTitles.count){
        return self.otherButtonTitles[buttonIndex];
    }else if (self.otherButtonTitles.count  == buttonIndex){
        return self.cancelButtonTitle;
    }
    return nil;
}
#pragma mark - operation methods
- (void)didTapBackground:(id)sender{
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES];
}
//取消
- (void)cancelButtonClicked:(id)sender{
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:YES];
}

#pragma mark -
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    if (self.actionSheetViewDelegate && [self.actionSheetViewDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
        [self.actionSheetViewDelegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
    }
    
    if (animated) {
        CGRect rect = CGRectMake(0, self.height, self.width, self.actionSheetView.frame.size.height);
        [UIView animateWithDuration:0.2 animations:^{
            [self.actionSheetView setFrame:rect];
            [self.backgroudView setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.actionSheetView && [self.actionSheetView respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
                [self.actionSheetViewDelegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
            }
        }];
    }else {
        [self removeFromSuperview];
        if (self.actionSheetViewDelegate && [self.actionSheetViewDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
            [self.actionSheetViewDelegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
        }
    }
}

#pragma mark - # Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewButtonCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ActionSheetCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActionSheetCell"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
    if (self.destructiveButtonTitle) {
        if (indexPath.row == 0) {
            [cell.textLabel setTextColor:COLOR_DESTRUCTIVE_TITLE];
            [cell.textLabel setText:self.destructiveButtonTitle];
        }
        else {
            [cell.textLabel setTextColor:BLACKCOLOR];
            [cell.textLabel setText:self.otherButtonTitles[indexPath.row - 1]];
        }
    }
    else {
        [cell.textLabel setTextColor:BLACKCOLOR];
        [cell.textLabel setText:self.otherButtonTitles[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithClickedButtonIndex:indexPath.row animated:YES];
    if (self.acitonSheetBlock) {
        self.acitonSheetBlock(indexPath.row);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIEdgeInsets edgeInset = UIEdgeInsetsZero;
    if ((self.destructiveButtonTitle && indexPath.row >= self.otherButtonTitles.count) || (!self.destructiveButtonTitle && indexPath.row >= self.otherButtonTitles.count - 1)) {
        edgeInset = UIEdgeInsetsMake(0, 0, 0, self.width);
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:edgeInset];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - 懒加载初始化视图
- (UIButton *)backgroudView{
    if (!_backgroudView) {
        _backgroudView = [[UIButton alloc] init];
        [_backgroudView setBackgroundColor:[UIColor blueColor]];
        [_backgroudView addTarget:self action:@selector(didTapBackground:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroudView;
}

- (UIView *)actionSheetView {
    if (!_actionSheetView) {
        _actionSheetView = [[UIView alloc] init];
        [_actionSheetView setBackgroundColor:WHITECOLOR];
    }
    return _actionSheetView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView setRowHeight:HEIGHT_BUTTON];
        [_tableView setBackgroundColor:RGBA(239.0, 239.0, 244.0, 1.0)];
        [_tableView setSeparatorColor:[UIColor colorWithWhite:0.5 alpha:0.3]];
        [_tableView setTableFooterView:[UIView new]];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _tableView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setBackgroundColor:WHITECOLOR];
        [_cancelButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_FONT_SIZE]];
        [_cancelButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithWhite:0.5 alpha:0.3]] forState:UIControlStateHighlighted];
    }
    return _cancelButton;
}

- (UILabel *)headerTitleLabel {
    if (!_headerTitleLabel) {
        _headerTitleLabel = [[UILabel alloc] init];
        [_headerTitleLabel setTextColor:[UIColor grayColor]];
        [_headerTitleLabel setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
        [_headerTitleLabel setNumberOfLines:0];
        [_headerTitleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _headerTitleLabel;
}


@end
