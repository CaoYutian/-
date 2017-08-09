//
//  QMPopUpMenu.m
//  inongtian
//
//  Created by KevinCao on 2016/10/27.
//  Copyright © 2016年 qianmo. All rights reserved.
//

#import "PopUpPickerView.h"

@interface PopUpPickerView () <UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIButton *finishBtn;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIPickerView *pickerView;
@end

@implementation PopUpPickerView

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, self.bgView.height, self.bgView.width, 200);
        [self addSubview:self.finishBtn];
        [self addSubview:self.pickerView];
    }
    return self;
}

-(void)show
{
    if (!self.bgView.superview) {
        [mainWindow() addSubview:self.bgView];
        if (!self.superview) {
            [self.bgView addSubview:self];
        }
    }
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.top = self.bgView.bottom-self.height;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.top = self.bgView.bottom;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
    }];
}

- (void)reloadData
{
    self.selectedRowArray = nil;
    [self.pickerView reloadAllComponents];
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        if ([self.dataSource numberOfComponentsInPickerView:self]) {
            if ([self.dataSource respondsToSelector:@selector(popUpMenu:numberOfRowsInComponent:)]) {
                if ([self.dataSource popUpMenu:self numberOfRowsInComponent:0]) {
                    [self.pickerView selectRow:0 inComponent:0 animated:YES];
                }
            }
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self.bgView];
    return !CGRectContainsPoint(self.frame, touchPoint);
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [self.dataSource numberOfComponentsInPickerView:self];
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.dataSource respondsToSelector:@selector(popUpMenu:numberOfRowsInComponent:)]) {
        return [self.dataSource popUpMenu:self numberOfRowsInComponent:component];
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(popUpMenu:titleForRow:forComponent:)]) {
        return [self.delegate popUpMenu:self titleForRow:row forComponent:component];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRowArray[component] = @(row);
    if (pickerView.numberOfComponents-1>component) {
        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:component+1 animated:YES];
        for (NSInteger i=component+1; i<self.selectedRowArray.count; i++) {
            self.selectedRowArray[i] = @0;
        }
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

#pragma mark - actions
- (void)tapAction
{
    [self dismiss];
}

- (void)finishAction
{
    if (self.selectedRowArray.count) {
        if ([self.delegate respondsToSelector:@selector(popUpMenu:didSelectRowArray:)]) {
            [self.delegate popUpMenu:self didSelectRowArray:self.selectedRowArray];
        }
    }
    [self dismiss];
}

#pragma mark - getters and setters
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        [tapGesture addTarget:self action:@selector(tapAction)];
        tapGesture.delegate = self;
        [_bgView addGestureRecognizer:tapGesture];
    }
    return _bgView;
}

-(UIButton *)finishBtn
{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishBtn.frame = CGRectMake(self.width-60, 0, 60, 40);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:MainBackgroundColor forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

-(UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.width, self.height-40)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(NSMutableArray *)selectedRowArray
{
    if (!_selectedRowArray) {
        _selectedRowArray = [NSMutableArray arrayWithCapacity:[self.pickerView numberOfComponents]];
        for (int i=0; i<[self.pickerView numberOfComponents]; i++) {
            self.selectedRowArray[i] = @(0);
        }
    }
    return _selectedRowArray;
}

@end
