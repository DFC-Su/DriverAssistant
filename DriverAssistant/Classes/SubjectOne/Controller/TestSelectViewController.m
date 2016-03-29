//
//  TestSelectViewController.m
//  DriverAssistant
//
//  Created by C on 16/3/28.
//  Copyright © 2016年 C. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"

@interface TestSelectViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _myTitle;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    [self loadTableView];

}

- (void)loadTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TestSelectCell";
    TestSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil]firstObject];
        cell.numberLabel.layer.cornerRadius = 8;
        cell.numberLabel.layer.masksToBounds = YES;
    }
    TestSelectModel *model = _dataArr[indexPath.row];
    cell.numberLabel.text = model.pid;
    cell.titleLable.text = model.pname;

    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerViewController *answerCtl = [[AnswerViewController alloc] init];
    answerCtl.number = indexPath.row;
    [self.navigationController pushViewController:answerCtl animated:YES];
}

@end
