//
//  SelectModelView.h
//  DriverAssistant
//
//  Created by C on 16/3/31.
//  Copyright © 2016年 C. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    testModel,
    lookingModel
}SelectModel;
typedef void(^SelectTouch)(SelectModel model);
@interface SelectModelView : UIView
@property (nonatomic, assign) SelectModel model;
- (SelectModelView *)initWithFrame:(CGRect)frame andTouch:(SelectTouch)touch;
@end
