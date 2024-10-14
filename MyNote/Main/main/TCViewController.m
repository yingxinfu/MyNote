//
//  TCViewController.m
//  SecurityNote
//
//  
//   Copyright  fuyingxin. All rights reserved.
//

#import "TCViewController.h"
#import "UIKit/UIKit.h"

@interface TCViewController ()

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation TCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 查找并引用导航栏下方的细线
       _navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    //状态栏为白色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
    
    //改变系统的导航栏
    UINavigationBar * navBar = [UINavigationBar appearance];
    
   
    //导航栏背影色
    [navBar setBarTintColor:[UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.3]];
    
    //导航栏标题为白色
    [navBar setBarStyle:UIBarStyleBlack];

    //导航栏返回条颜色
    navBar.tintColor = [UIColor whiteColor];
    
    
    //设置BarButtonItem的主题
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"synchronous"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    NSMutableDictionary * itemAttrys = [NSMutableDictionary dictionary];
    
    itemAttrys[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //itemAttrys [NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    [item setTitleTextAttributes:itemAttrys forState:UIControlStateNormal];
    
    //tab bar 颜色
    UITabBar * tabBar = [UITabBar appearance];
    tabBar.tintColor = [UIColor colorWithRed:1.0 green:182/255.0 blue:193/255.0 alpha:0.68];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 隐藏导航栏的细线
    _navBarHairlineImageView.hidden = YES;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
