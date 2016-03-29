//
//  ViewController.m
//  DriverAssistant
//
//  Created by C on 16/3/28.
//  Copyright © 2016年 C. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "SubjectOneViewController.h"

@interface ViewController ()
{
    SelectView *_selectView;
    __weak IBOutlet UIButton *selectBtn;
}
@end

@implementation ViewController

- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
        }
            break;
        case 101://科目一
        {
            SubjectOneViewController *ctl = [[SubjectOneViewController alloc] init];
            ctl.myTitle = @"科目一 理论考试";
            [self.navigationController pushViewController:ctl animated:YES];
        }
            break;
        case 102://科目二
        {
            
        }
            break;
        case 103://科目三
        {
            
        }
            break;
        case 104://科目四
        {
            
        }
            break;
        case 105:
        {
            
        }
        case 106:
        {
            
        }
            break;
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    _selectView = [[SelectView alloc] initWithFrame:self.view.frame andBtn:selectBtn];
    _selectView.alpha = 0;
    [self.view addSubview:_selectView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
