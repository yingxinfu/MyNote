//
//  TCYearPickerView.h
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TCYearPickerViewDelegate <NSObject>

//协议，代理
@optional

-(void)didCancelSelectYear;

-(void)didSaveYear;

@end


@interface TCYearPickerView : UIView

@property (nonatomic, weak) UIPickerView * yearPickers;
@property (nonatomic, weak) id<TCYearPickerViewDelegate> delegate;


+(TCYearPickerView *)initWithPicker:(CGRect )viewFrame;

-(void) popYearPickerView;

-(void) hiddenYearPickerView;


@end
