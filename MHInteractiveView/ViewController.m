//
//  ViewController.m
//  MHInteractiveView
//
//  Created by 孟辉 on 15/11/25.
//  Copyright © 2016年 iasku. All rights reserved.
//

#define kSCREENW [UIScreen mainScreen].bounds.size.width
#define kSCREENH [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "InteractiveView.h"
#import "UIColor+FlatUI.h"

@interface ViewController ()<InteractiveViewProtocol>

@property (nonatomic,strong)InteractiveView *interactiveView;
@property (nonatomic, assign) CGRect interactiveViewRect;
@end

@implementation ViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self  name:UIKeyboardWillHideNotification    object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //注册通知,监听键盘出现
    self.interactiveViewRect = CGRectMake(0,kSCREENH  - 50, kSCREENW,50);
    [self.view addSubview:self.interactiveView];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(hideKeyboardDidShow:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
    
}
- (void)hideKeyboardDidShow:(NSNotification*)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect rect=self.interactiveViewRect;
    NSLog(@"%f",keyboardRect.size.height);
    NSLog(@"%@",NSStringFromCGRect(self.interactiveView.frame));
    self.interactiveView.frame=CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect rect=self.interactiveViewRect;
    NSLog(@"%f",keyboardRect.size.height);
    self.interactiveView.frame=CGRectMake(rect.origin.x, rect.origin.y-keyboardRect.size.height, rect.size.width, rect.size.height);
    NSLog(@"%@",NSStringFromCGRect(self.interactiveView.frame));
}
- (InteractiveView *)interactiveView
{
    if (!_interactiveView) {
        _interactiveView=[[InteractiveView alloc]initWithFrame:self.interactiveViewRect];
        _interactiveView.delegate=self;
        _interactiveView.contentView.backgroundColor=[UIColor whiteColor];
        _interactiveView.placeholder = @"拍照或文字回答";
        _interactiveView.backgroundColor=  [UIColor colorFromHexCode:@"ebebeb"];
        //        _interactiveView.hidden = YES;
    }
    return _interactiveView;
}
-  (void)interactiveView:(InteractiveView *)interactiveView willChangeHeight:(CGFloat)height
{
    NSLog(@"%@",NSStringFromCGRect(self.interactiveView.frame));
    CGFloat oldHeight = CGRectGetHeight(self.interactiveView.frame);
    self.interactiveView.frame = CGRectMake(0, CGRectGetMinY(self.interactiveView.frame)- height + oldHeight, kSCREENW,height);
    NSLog(@"%@",NSStringFromCGRect(self.interactiveView.frame));
}
-(void)messageWillSend:(UIImage*)sendImage text:(NSString*)sendText{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
