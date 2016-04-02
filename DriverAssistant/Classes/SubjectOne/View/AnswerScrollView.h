//
//  AnswerScrollView.h
//  DriverAssistant
//
//  Created by C on 16/3/29.
//  Copyright © 2016年 C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;
-(void)reloadData;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) int currentPage;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *hadAnswerArray;

@end
