//
//  AnswerScrollView.m
//  DriverAssistant
//
//  Created by C on 16/3/29.
//  Copyright © 2016年 C. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#define SIZE self.frame.size

@interface AnswerScrollView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    
}

@end

@implementation AnswerScrollView
{
    UIScrollView *_scrollView;
    UITableView *_leftTableView;
    UITableView *_centerTableView;
    UITableView *_rightTableView;
    NSArray *_dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        _dataArray = [NSArray arrayWithArray:array];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        
        _leftTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _centerTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _centerTableView.delegate = self;
        _rightTableView.delegate = self;
        _leftTableView.dataSource = self;
        _centerTableView.dataSource = self;
        _rightTableView.dataSource = self;
        
        if (_dataArray.count>1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, 0);
        }
        [self creatView];
    }
    return self;
}

- (void) creatView
{
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _centerTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_centerTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
    
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AnswerCell";
    AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]firstObject];
        cell.numberLabel.layer.cornerRadius = 10;
        cell.numberLabel.layer.masksToBounds = YES;
        if (indexPath.row % 2 == 0) {
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0];
        }
    }
    AnswerModel *model;
    model = [self getTheFitModel:tableView];
    cell.numberLabel.text = [NSString stringWithFormat:@"%c", (char)('A'+indexPath.row)];
        if ([model.mtype intValue] == 1) {
        cell.answerLabel.text = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
    }
    
    return cell;
}

- (AnswerModel *)getTheFitModel:(UITableView *)tableView
{
    AnswerModel *model;
    if (tableView == _leftTableView && _currentPage == 0) {
        model = _dataArray[_currentPage];
    }else if(tableView == _leftTableView && _currentPage > 0){
        model = _dataArray[_currentPage-1];
    }else if (tableView == _centerTableView && _currentPage == 0){
        model = _dataArray[_currentPage+1];
    }else if (tableView == _centerTableView&&_currentPage>0&&_currentPage<_dataArray.count-1){
        model = _dataArray[_currentPage];
    }else if (tableView==_centerTableView&&_currentPage==_dataArray.count-1){
        model = _dataArray[_currentPage-1];
    }else if (tableView==_rightTableView&&_currentPage==_dataArray.count-1){
        model = _dataArray[_currentPage];
    }else if (tableView==_rightTableView&&_currentPage<_dataArray.count-1){
        model = _dataArray[_currentPage+1];
    }
    return model;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat hight;
    NSString *str;
    AnswerModel *model = [self getTheFitModel:tableView];
    if ([model.mtype intValue]==1){
        str = [[Tools getAnswerWithString:model.mquestion] objectAtIndex:0];
    }else{
        str = model.mquestion;
    }
    UIFont *font = [UIFont systemFontOfSize:16];
    hight = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height + 20;
    if (hight<=80) {
        return 80;
    }
    else{
        return hight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    AnswerModel *model = [self getTheFitModel:tableView];
    NSString *str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    return [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height + 20;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat hight;
    NSString *str;
    AnswerModel *model = [self getTheFitModel:tableView];
    if ([model.mtype intValue]==1){
        str = [[Tools getAnswerWithString:model.mquestion] objectAtIndex:0];
    }else{
        str = model.mquestion;
    }
    UIFont *font = [UIFont systemFontOfSize:16];
    hight = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height + 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, hight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 20, hight - 20)];
    label.text = [NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    [view addSubview:label];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    AnswerModel *model = [self getTheFitModel:tableView];
    NSString *str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    CGFloat hight = [Tools getSizeWithString:str withFont:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height + 20;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, hight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 20, hight - 20)];
    label.text = [NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.textColor = [UIColor blueColor];
    [view addSubview:label];
    return view;
}

/**
 获取当前题目编号
 */
- (int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page
{
    if (tableView==_leftTableView&&page==0) {
        return 1;
    }else if (tableView==_leftTableView&&page>0){
        return page;
    }else if (tableView==_centerTableView&&page>0&&page<_dataArray.count-1){
        return page+1;
    }else if (tableView==_centerTableView&&page==0){
        return 2;
    }else if (tableView==_centerTableView&&page==_dataArray.count-1){
        return page;
    }else if (tableView==_rightTableView&&page<_dataArray.count-1){
        return page+1;
    }
    return 0;
}

#pragma mark - scrollView delegate
//滚动结束时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
    int page = (int)currentOffset.x/SIZE.width;
    if (page < _dataArray.count - 1 && page > 0) {
        _scrollView.contentSize = CGSizeMake(currentOffset.x +SIZE.width*2, 0);
        _leftTableView.frame = CGRectMake(currentOffset.x - SIZE.width, 0, SIZE.width, SIZE.height);
        _centerTableView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _rightTableView.frame = CGRectMake(currentOffset.x + SIZE.width, 0, SIZE.width, SIZE.height);
        _currentPage = page;
        [self reloadData];
    }
}

- (void)reloadData
{
    [_leftTableView reloadData];
    [_centerTableView reloadData];
    [_rightTableView reloadData];
}
@end
