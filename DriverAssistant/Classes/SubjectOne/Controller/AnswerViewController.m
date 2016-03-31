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
@interface AnswerViewController ()
{
    AnswerScrollView *_answerScrollView;
    SelectModelView * modelView;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *array = [DataManger getData:answer];
    for (int i = 0; i < array.count - 1; i++) {
        AnswerModel *model = array[i];
        if ([model.pid intValue] == _number+1) {
            [arr addObject:model];
        }
    }
    _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60-64) withDataArray:arr];
    [self.view addSubview:_answerScrollView];
    [self creatToolBar];
    [self creatModelView];
}

- (void)creatToolBar{
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"111",@"查看答案",@"收藏本题"];
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

- (void)onClickToolBar:(UIButton *)btn
{
    switch (btn.tag) {
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
@end
