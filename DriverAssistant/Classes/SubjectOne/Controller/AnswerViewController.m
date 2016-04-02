//
//  AnswerViewController.m
//  DriverAssistant
//
//  Created by C on 16/3/29.
//  Copyright © 2016年 C. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "DataManger.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
@interface AnswerViewController ()<SheetViewDelegate>
{
    AnswerScrollView *_answerScrollView;
    SelectModelView * modelView;
    SheetView *_sheetView;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = _myTitle;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatData];
    [self.view addSubview:_answerScrollView];
    [self creatToolBar];
    [self creatModelView];
    [self creatSheetView];
}

- (void)creatData{
    if (_type == 1) {
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *array = [DataManger getData:answer];
        for (int i = 0; i < array.count - 1; i++) {
            AnswerModel *model = array[i];
            if ([model.pid intValue] == _number+1) {
                [arr addObject:model];
            }
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-64) withDataArray:arr];
    }else if (_type == 2){//顺序练习
         _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-64) withDataArray:[DataManger getData:answer]];
    }else if (_type == 3){//随机练习
        NSMutableArray *tempArr = [NSMutableArray array];
        NSArray *array = [DataManger getData:answer];
        NSMutableArray *dataArr = [NSMutableArray array];
        [tempArr addObjectsFromArray:array];
        for (int i=0; i<tempArr.count; i++) {
            int index = arc4random()%(tempArr.count);
            [dataArr addObject:tempArr[index]];
            [tempArr removeObject:tempArr[index]];
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-64) withDataArray:tempArr];
    }else if (_type == 4){//专项练习
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *array = [DataManger getData:answer];
        for (int i = 0; i < array.count - 1; i++) {
            AnswerModel *model = array[i];
            if ([model.sid intValue] == _number+1) {
                [arr addObject:model];
            }
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-64) withDataArray:arr];    }

}

- (void)creatToolBar{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[[NSString stringWithFormat:@"%lu",(unsigned long)_answerScrollView.dataArray.count],@"查看答案",@"收藏本题"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 301+i;
        btn.frame = CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(onClickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.center.x - 30, 40, 60, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];

}

- (void)creatModelView
{
    modelView = [[SelectModelView alloc] initWithFrame:self.view.frame andTouch:^(SelectModel model) {
        NSLog(@"当前模式%d",model);
    }];
    [self.view addSubview:modelView];
    modelView.alpha = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)modelChange:(UIBarButtonItem *)item
{
    [UIView animateWithDuration:0.3 animations:^{
        modelView.alpha = 1;
    }];
}

- (void)creatSheetView
{
    _sheetView = [[SheetView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) withSuperView:self.view andQuestionCount:50];
    [self.view addSubview:_sheetView];
}

- (void)onClickToolBar:(UIButton *)btn
{
    switch (btn.tag) {
        case 301://上拉抽屉
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView.backView.alpha = 0.8;
                _sheetView.delegate = self;
            }];
        }
            break;
        case 302://查看答案
        {
            if ([_answerScrollView.hadAnswerArray[_answerScrollView.currentPage] intValue]!=0) {
                return;
            }else{
                AnswerModel * model = [_answerScrollView.dataArray objectAtIndex:_answerScrollView.currentPage];
                NSString * answer = model.manswer;
                char an = [answer characterAtIndex:0];
                
                [_answerScrollView.hadAnswerArray replaceObjectAtIndex:_answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
                [_answerScrollView reloadData];
            }
    
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - SheetViewDelegate
- (void)SheetViewClick:(int)index
{
    UIScrollView *scrollView = _answerScrollView.scrollView;
    scrollView.contentOffset = CGPointMake((index-1)*scrollView.frame.size.width, 0);
    [scrollView.delegate scrollViewDidEndDecelerating:scrollView];
}
@end
