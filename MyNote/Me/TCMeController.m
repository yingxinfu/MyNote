//
//  TCMeController.m
//  SecurityNote
//
//  Created by joonsheng on 14-8-12.
//   Copyright  fuyingxin. All rights reserved.
//

#import "TCMeController.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD+MJ.h"
#import "TCAbutSNoteViewController.h"
#import "TCHelpViewController.h"
#import "TCRewardTableViewController.h"
#import "DYFAuthIDAndGestureLockSettingsController.h"

#import <StoreKit/StoreKit.h>
#import <SafariServices/SafariServices.h>

#import "SecurityNote-Swift.h"

@interface TCMeController ()<UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageHead;

@property (weak, nonatomic) IBOutlet UITableViewCell *imageCell;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableViewCell *textCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *helpCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *feedBackCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *recommed;
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutSnot;
@property (weak, nonatomic) IBOutlet UITableViewCell *userprotocolBtn;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView; // 使用属性定义

@end

@implementation TCMeController

NSTimer * timer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // 创建 UIImageView 并设置左侧图片
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"灯"]];
        leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        leftImageView.frame = CGRectMake(0, 0, 1, 1); // 根据需要设置尺寸

        // 将 UIImageView 设置为导航栏的左侧按钮
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftImageView];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;

        // 创建 UIImageView 并设置右侧图片
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"灯"]];
        rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        rightImageView.frame = CGRectMake(0, 0, 1, 1); // 根据需要设置尺寸

        // 将 UIImageView 设置为导航栏的右侧按钮
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightImageView];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    // 查找并引用导航栏下方的细线
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    }

    //设置Table属性
    self.tableView.separatorColor = [UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.3];

    self.imageCell.selectedBackgroundView = [[UIView alloc]initWithFrame:self.imageCell.frame];
    self.imageCell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.12];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 

    //设置文字
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    //判断是否有存储帐号，如果有，就显示出来
    if ([defaults valueForKey:@"textView"])
    {
        self.textView.text = [defaults valueForKey:@"textView"];
    }
    else
    {
       self.textView.text = @"我的日记。";
       self.textView.font = [UIFont systemFontOfSize:20.0];
    }
    
    //设置头像属性
    
    /*读取入图片*/
    //Document
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.png"];
    
    //因为拿到的是个路径，所以把它加载成一个data对象
    NSData *data=[NSData dataWithContentsOfFile:uniquePath];
    
    //判断是否存储照片，如果没有就用默认
    if (data)
    {
        //把该图片读出来
        UIImage * image = [UIImage imageWithData:data];
        //CGFloat min = MIN(image.size.width, image.size.height);
        self.imageHead.image = image;
    }
    else
    {
         [self.imageHead setImage:[self ellipseImage:[UIImage imageNamed:@"IMG_7665.jpg"] withInset:0 withBorderWidth:5 withBorderColor:nil]];
    }
    
    self.imageHead.layer.cornerRadius = self.imageHead.frame.size.width/2;
    self.imageHead.layer.masksToBounds = YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 200;
    }
    
    
    return 35;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 隐藏导航栏的细线
    self.navBarHairlineImageView.hidden = YES;
    
//    // 检查是否已经播放过糖果烟花动画
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        BOOL hasShownCandyFirework = [defaults boolForKey:@"HasShownCandyFirework"];
//        
//        if (!hasShownCandyFirework) {
//            [self playCandyFireworkAnimation]; // 播放糖果烟花动画
//            
//            // 记录动画已播放
//            [defaults setBool:YES forKey:@"HasShownCandyFirework"];
//            [defaults synchronize];
//        }
}

- (void)playCandyFireworkAnimation {
    // 创建糖果视图
        UIImageView *candyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG1.jpg"]];
        candyImageView.frame = CGRectMake((self.view.bounds.size.width - 50) / 2, -50, 80, 80); // 初始位置在屏幕顶部
        [self.view addSubview:candyImageView];

        // 目标位置，假设你想让糖果掉落到屏幕中间的某个位置
        CGPoint targetPosition = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 100); // 修改这个位置以适应你的需求

        // 设置掉落动画
        [UIView animateWithDuration:3.0 // 动画持续时间
                              delay:0.0 // 动画延迟
                            options:UIViewAnimationOptionCurveEaseIn // 动画曲线
                         animations:^{
            // 更新糖果视图的位置
            candyImageView.center = targetPosition; // 设置糖果的最终位置
        } completion:^(BOOL finished) {
            // 动画完成后的操作（可选）
            NSLog(@"Candy dropped!");
        }];
}

- (void)dealloc
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"HasShownCandyFirework"];
    [defaults synchronize];
}


// 查找细线的递归方法
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }

    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }

    return nil;
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.clearColor;
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //设置照片
    if ([indexPath section] == 0 && [indexPath row] == 0)
    {
        UIActionSheet * sheets = [[UIActionSheet alloc]initWithTitle:@"选择更换您头像的方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",@"选择默认头像", nil];
        
        sheets.actionSheetStyle = UIActionSheetStyleAutomatic;
        
        //帮定tag
        sheets.tag = 1;
        
        [sheets showInView:self.view];
    }
    
    //设置文字
    if ([indexPath section] == 0 && [indexPath row] == 1)
    {
        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"编辑" message:@"请输入你的密语" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alter.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        //拿到当前选中列表的文字
        [alter textFieldAtIndex:0].text = self.textView.text;
        
        //显示文本框的x
        [alter textFieldAtIndex:0].clearButtonMode =UITextFieldViewModeWhileEditing;
        
        [alter show];
    }
    
    
}


//alertView方法调用,需要实现UIAlertViewDelegate协议
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {

    }
    
    //确定按钮
    if (buttonIndex == 1)
    {
        self.textView.text = [alertView textFieldAtIndex:0].text;
        
        NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
        [defaults setValue:self.textView.text forKey:@"textView"];
        [defaults synchronize];
    }
}


//处理Sheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //点击了头像
    if (actionSheet.tag == 1 && buttonIndex == 0)
    {
        //拍照
        UIImagePickerController * camera = [[UIImagePickerController alloc]init];
        
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        camera.delegate = self;
        
        [self presentViewController:camera animated:YES completion:^{
            
            
        }];
        
        
    }
    else if(actionSheet.tag == 1 && buttonIndex == 1)
    {
        //从相册
        UIImagePickerController * photo = [[UIImagePickerController alloc]init];
        
        photo.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        photo.delegate = self;
        
        [self presentViewController:photo animated:YES completion:^{
            
        
        }];
        
    }
    else if(actionSheet.tag == 1 && buttonIndex == 2)
    {
        //默认头像
        
        UIImage * newImage  = [self ellipseImage:[UIImage imageNamed:@"IMG_7665.jpg"] withInset:0 withBorderWidth:15 withBorderColor:TCCoror(0, 0, 0)];
        
        [self.imageHead setImage:newImage];
        
        //存储头像图片
        //Document
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        
        /*写入图片*/
        //帮文件起个名
        NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.png"];
        //将图片写到Documents文件中
        [UIImagePNGRepresentation(newImage) writeToFile:uniquePath atomically:YES];
        
    }
    

}


//处理头像
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     [picker dismissViewControllerAnimated:YES completion:^{
         
     }];
    
    UIImage * newImage = info[UIImagePickerControllerOriginalImage];
    
//    UIImage * newImage  = [self ellipseImage:image withInset:0 withBorderWidth:15 withBorderColor:TCCoror(38, 141, 252)];
    [self.imageHead setImage:newImage];
  
    
    //存储头像图片
    //Document
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);

    /*写入图片*/
    //帮文件起个名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.png"];
    //将图片写到Documents文件中
    [UIImagePNGRepresentation(newImage) writeToFile:uniquePath atomically:YES];

}


//处理短信
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
    {
        //NSLog(@"取消发送");
        [MBProgressHUD showSuccess:@"已取消发送"];
        
    }
    else if (result == MessageComposeResultSent)
    {
        //NSLog(@"已经发出");
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } else
    {
        //NSLog(@"发送失败");
        [MBProgressHUD showError:@"发送失败"];
    }
    
    
    //定时器关闭提示
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(didhideHUD) userInfo:nil repeats:NO];
}



//处理邮件
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // 关闭邮件界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultCancelled)
    {
        [MBRoundProgressView setAnimationDelay:1];
        //NSLog(@"取消发送");
        [MBProgressHUD showSuccess:@"已取消发送"];
        
    } else if (result == MFMailComposeResultSent)
    {
        //NSLog(@"已经发出");
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } else
    {
        //NSLog(@"发送失败");
        [MBProgressHUD showError:@"发送失败"];
    }
    
    //定时器关闭提示
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(didhideHUD) userInfo:nil repeats:NO];
}


//隐藏提示框
-(void)didhideHUD
{
    
    [MBProgressHUD hideHUD];
    
}


//设置圆形头像
- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f , image.size.height - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width);
        CGContextAddEllipseInRect(context, CGRectMake(inset + width/2, inset +  width/2, image.size.width - width- inset * 2.0f, image.size.height - width - inset * 2.0f));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (void)openWebView:(NSString *)url
{
    if (@available(iOS 9.0, *)) {
        SFSafariViewController *sf = [[SFSafariViewController alloc] initWithURL:[[NSURL alloc] initWithString:url]];
        if (@available(iOS 10.0, *)) {
            sf.preferredBarTintColor = [UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.3];
            sf.preferredControlTintColor = [UIColor whiteColor];
        }
        if (@available(iOS 11.0, *)) {
            sf.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
        }
        [self presentViewController:sf animated:YES completion:nil];
    }
    else {
        NSURL * urlstr = [NSURL URLWithString:url];
        [[UIApplication sharedApplication] openURL:urlstr];
    }
}

@end
