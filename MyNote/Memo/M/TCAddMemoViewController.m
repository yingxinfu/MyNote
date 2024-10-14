//
//  TCAddMemoViewController.m
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import "TCAddMemoViewController.h"
#import "TCDatePickerView.h"
#import "TCMemo.h"
#import "MBProgressHUD+MJ.h"
#import "TCYearPickerView.h"
#import "DHDeviceUtil.h"

@interface TCAddMemoViewController ()<UITextFieldDelegate,TCDatePickerViewDelegate, TCYearPickerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UITextField * titleField;
@property (nonatomic, weak) UITextView * detailView;
@property (nonatomic, weak) UITextField * memotypeF;
@property (nonatomic, weak) UILabel * yearL;
@property (nonatomic, weak) UILabel * timeL;

@property (nonatomic, strong) TCDatePickerView * pickerView;
@property (nonatomic, strong) TCYearPickerView * yearPickerV;
@property (nonatomic, strong) TCMemo * memoNote;

@property (nonatomic, strong) NSMutableArray * yearArray;

@property (nonatomic, copy) dispatch_block_t completionBlock;

@end

@implementation TCAddMemoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    //导航栏颜色
    [self topColor];
    
    //主标题
    [self titleLabel];
    
    //标题
    [self titleFileds];
    
    //备忘内容
    [self detailViews];
    
    //取消返回
    [self backBtn];
    
    //保存更改
    [self saveBtn];
    
    //时间标签
    [self showTime];
    
    //年份标签
    [self showYear];
    
    //备忘类型标签
    [self showMemoType];
    
    
    
    //时间选择器 !!!必须放在最后，点击时，可以显示出来
    self.pickerView = [TCDatePickerView initWithPicker:self.view.frame];
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];
    
    
    
    self.yearPickerV = [TCYearPickerView initWithPicker:self.view.frame];
    //TCYearPickerView的代理
    self.yearPickerV.delegate = self;
    [self.view addSubview:self.yearPickerV];
    
    
    //pickerView的代理
    self.yearPickerV.yearPickers.delegate = self;
    self.yearPickerV.yearPickers.dataSource = self;

}


//懒加载
-(TCMemo *)memoNote
{
    if (_memoNote == nil)
    {
        _memoNote = [[TCMemo alloc]init];
    }
    
    return _memoNote;
}


//自定义年份picker
-(NSMutableArray *)yearArray
{
    if (_yearArray == nil)
    {
        _yearArray = [NSMutableArray array];
        
        for (int j = 0; j < 100; j ++)
        {
            NSString * yearStr = [NSString stringWithFormat:@"2%03d年",j];
            
            [self.yearArray addObject:yearStr];
        }
        
    }
    return _yearArray;
}


//导航栏颜色
-(void)topColor
{
    CGFloat top = 60 + (MACRO_IS_IPHONE_X ? 24 : 0);
    UIView * topColor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, top)];
    
    topColor.backgroundColor  = [UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.3];
    
    [self.view addSubview:topColor];
    
}

//备忘
-(void)titleLabel
{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    titleLabel.center = CGPointMake(self.view.frame.size.width /2, 40);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"备忘";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:titleLabel];
}

//备忘的标题
-(void)titleFileds
{
    
    UITextField * titleField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 35)];
    titleField.center = CGPointMake(self.view.frame.size.width /2, 72.5);
    titleField.font = [UIFont boldSystemFontOfSize:23];
    titleField.placeholder = @"备忘标题";
    titleField.textAlignment = NSTextAlignmentCenter;
    titleField.clearButtonMode =UITextFieldViewModeWhileEditing;
    [titleField becomeFirstResponder];
    
    //        titleField.layer.borderWidth = 2;
    //        titleField.layer.borderColor = [[UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.3] CGColor];
    self.titleField = titleField;
    
    [self.view addSubview:titleField];
    
}


//内容栏
-(void)detailViews
{
    CGFloat top = 120 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UITextView * detailView =[[UITextView alloc]initWithFrame:CGRectMake(10, top, self.view.frame.size.width - 20, self.view.frame.size.height - top)];
    detailView.font = [UIFont systemFontOfSize:18];
    detailView.layer.borderWidth = 1.5;
    detailView.layer.borderColor = [[UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.3] CGColor];
    detailView.layer.cornerRadius = 4.0f;
    detailView.alwaysBounceVertical = YES;
    self.detailView = detailView;
    self.detailView.delegate = self;
    //初始化
    detailView.text = @"\n\n\n\n\n\n\n\n\n";

    [self.view addSubview:detailView];
    
}


//年份标签
-(void)showYear
{
    CGFloat top = 93 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UILabel * yearL = [[UILabel alloc]initWithFrame:CGRectMake(10, top, 60, 15)];
    yearL.font = [UIFont systemFontOfSize:16];
    yearL.textAlignment = NSTextAlignmentCenter;
    yearL.text = [TCDatePickerView getNowDateFormat:@"yyyy年"];
    self.yearL = yearL;
    [self.view addSubview:yearL];
    
    self.memoNote.year = yearL.text;
    
    //提供点击显示时间选择器
    UIButton * touchYearL = [[UIButton alloc]initWithFrame:CGRectMake(10, top, 60, 15)];
    
    [touchYearL addTarget:self action:@selector(showYearPicker) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:touchYearL];
    
}


//年份选择器
-(void)showYearPicker
{
    //隐藏时间选择器，显示年份选择器
    [self.pickerView hiddenDatePickerView];
    [self.yearPickerV popYearPickerView];

    //默认选中今年
    NSString * yearRow = [TCDatePickerView getNowDateFormat:@"yy"];
    [self.yearPickerV.yearPickers selectRow:[yearRow intValue] inComponent:0 animated:YES];
    
   [self.view endEditing:YES];
    
}


//时间标签
-(void)showTime
{
    CGFloat top = 93 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UILabel * timeL =[[UILabel alloc]initWithFrame:CGRectMake(70, top, 120, 15)];
    timeL.text = [TCDatePickerView getNowDateFormat:@"M月d日 HH:mm"];
    timeL.font = [UIFont systemFontOfSize:16];
    // dateLabel.userInteractionEnabled = YES;
    self.timeL = timeL;
    [self.view addSubview:timeL];
    
    self.memoNote.time = timeL.text;
    
    //提供点击显示时间选择器
    UIButton * touchLabel = [[UIButton alloc]initWithFrame:CGRectMake(70, top, 120, 15)];
    [touchLabel addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:touchLabel];
    
}


//时间选择器
-(void)showPicker
{

    //隐藏年份选择器，显示时间选择器
    [self.yearPickerV hiddenYearPickerView];
    [self.pickerView popDatePickerView];
    
    //点击DateLable时，归零(到现在的时间）
    [self.pickerView resetToZero];
    
    [self.view endEditing:YES];
    
}


//备忘类型标签
-(void)showMemoType
{
    CGFloat top = 93 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UITextField * memotypeF = [[UITextField alloc]initWithFrame:CGRectMake(190, top, self.view.frame.size.width - 190, 20)];
    memotypeF.font = [UIFont systemFontOfSize:16];
    memotypeF.placeholder = @"备忘类型";
    memotypeF.textAlignment = NSTextAlignmentCenter;
    memotypeF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.memotypeF = memotypeF;
    
    [self.view addSubview:memotypeF];
    
}


//取消按钮
-(void)backBtn
{
    CGFloat top = 30 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UIButton * backBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [backBn  setFrame:CGRectMake(5, top, 60, 30)];
    
    [backBn setTitle:@"取消" forState:UIControlStateNormal];
    
    backBn.tintColor = [UIColor whiteColor];
    
    backBn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [backBn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBn];
}


//选择按钮
-(void)saveBtn
{
    CGFloat top = 30 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UIButton * saveBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [saveBn  setFrame:CGRectMake(self.view.frame.size.width - 65 , top, 60, 30)];
    
    [saveBn setTitle:@"保存" forState:UIControlStateNormal];
    
    saveBn.tintColor = [UIColor whiteColor];
    
    saveBn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [saveBn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveBn];
    
}



//取消保存
-(void)back:(id)sender
{
    
    [self.view endEditing:YES];
    
    self.memoNote = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    
}


//保存备忘
-(void)save:(id)sender
{
    
    //标题不能为空
    if ([self.titleField.text length] == 0)
    {
        [MBProgressHUD showError:@"标题不能为空"];
        return ;
    }
    
    //隐藏时间选择器
    [self.pickerView hiddenDatePickerView];
    [self.yearPickerV hiddenYearPickerView];
    [self.view endEditing:YES];
    
    
    self.memoNote.title = self.titleField.text;
    self.memoNote.content = self.detailView.text;
    self.memoNote.memotype = self.memotypeF.text;
    
    //插入到数据库中
    [self.memoNote insertNote:self.memoNote];
    
    !self.completionBlock ?:self.completionBlock();
    
    //返回
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)viewDidColseCompletion:(void (^)(void))completion
{
    self.completionBlock = completion;
}



//取消时间选择器
-(void)didCancelSelectDate
{
    self.timeL.text = self.memoNote.time;
}


//保存时间选择
-(void)didSaveDate
{
    self.memoNote.time = self.timeL.text;
    
}


//时间选择器改变时，同时改变time标签的时间
-(void)didDateChangeTo
{
    self.timeL.text = [self.pickerView getNowDatePicker:@"M月d日 HH:mm"];
}


//取消年份选择器
-(void)didCancelSelectYear
{
    self.yearL.text = self.memoNote.year;
}


//保存年份选择
-(void)didSaveYear
{
    self.memoNote.year = self.yearL.text;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.view endEditing:YES];
    
    //隐藏时间选择器
    [self.pickerView hiddenDatePickerView];
}


//设置代理后，点击return，响应
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}



//包含多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


//包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.yearArray.count;
}


//指定列表和列表项的标题文本
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.yearArray objectAtIndex:row];
    
}


//选中列表时，激发
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.yearL.text = [self.yearArray objectAtIndex:row];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    //隐藏时间选择器
    [self.pickerView hiddenDatePickerView];
    [self.yearPickerV hiddenYearPickerView];
    
}



@end
