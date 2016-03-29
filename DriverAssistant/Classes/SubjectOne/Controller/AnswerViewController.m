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
@interface AnswerViewController ()

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
    AnswerScrollView *view = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) withDataArray:arr];
    [self.view addSubview:view];
}


@end
