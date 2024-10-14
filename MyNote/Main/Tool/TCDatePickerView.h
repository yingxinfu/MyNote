//
//  TCDatePickerView.h
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCDatePickerViewDelegate <NSObject>

//协议，代理
@optional

-(void)didCancelSelectDate;

-(void)didSaveDate;

-(void)didDateChangeTo;

@end


@interface TCDatePickerView : UIView


@property (nonatomic, weak) UIDatePicker * datePickers;

@property (nonatomic, weak) id<TCDatePickerViewDelegate> delegate;

+(TCDatePickerView *)initWithPicker:(CGRect )viewFrame;

+(TCDatePickerView *)initWithPicker;

//获取当前时间，格式自己定义
+(NSString *)getNowDateFormat:(NSString *)date;

-(NSString *)getNowDatePicker:(NSString *)date;


-(void) resetToZero;

-(void) popDatePickerView;

-(void) hiddenDatePickerView;

-(void) datePickerWillHidden:(BOOL)hidder;



@end
