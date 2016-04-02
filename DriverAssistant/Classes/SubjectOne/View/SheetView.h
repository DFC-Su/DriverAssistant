//
//  SheetView.h
//  DriverAssistant
//
//  Created by C on 16/3/31.
//  Copyright © 2016年 C. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SheetViewDelegate
-(void)SheetViewClick:(int)index;
@end
@interface SheetView : UIView
@property(nonatomic,weak)id<SheetViewDelegate> delegate;
@property (nonatomic, strong) UIView *backView;

- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuestionCount:(int)count;
@end
