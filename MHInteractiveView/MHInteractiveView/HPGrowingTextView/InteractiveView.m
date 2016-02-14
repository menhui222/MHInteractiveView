//
//  InteractiveView.m
//  MHInteractiveView
//
//  Created by 孟辉 on 15/11/25.
//  Copyright © 2016年 iasku. All rights reserved.
////

#import "InteractiveView.h"
#import "UIColor+FlatUI.h"


@implementation InteractiveView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        lineView.backgroundColor = [UIColor colorFromHexCode:@"b2b2b2"];
        [self addSubview:lineView];
        [self addSubview:self.cameraButton];
        [self addSubview:self.sendButton];
        [self addSubview:self.contentView];
        self.backgroundColor=[UIColor colorFromHexCode:@"ebebeb"];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    if (_hideCameraButton) {
        self.cameraButton.frame = CGRectZero;
    }
    else
    {
        self.cameraButton.frame = CGRectMake(10, 10, 30, 30);
    }
    self.sendButton.frame = CGRectMake(CGRectGetWidth(self.bounds)-CGRectGetWidth(self.sendButton.bounds)-10, 5, CGRectGetWidth(self.sendButton.bounds), CGRectGetHeight(self.bounds)-10);
    self.contentView.frame = CGRectMake(CGRectGetMaxX(self.cameraButton.frame)+10, 5, CGRectGetMinX(self.sendButton.frame)-CGRectGetMaxX(self.cameraButton.frame)-20,CGRectGetHeight(self.bounds)-10);
}

#pragma mark -- getset
-(HPGrowingTextView*)contentView{
    if (!_contentView) {

        _contentView=[[HPGrowingTextView alloc]init];
        _contentView.delegate  = self;
        _contentView.maxNumberOfLines = 4;
        _contentView.minNumberOfLines = 1;
         self.contentView.frame=CGRectMake(CGRectGetMaxX(self.cameraButton.frame)+10, 5, CGRectGetMinX(self.sendButton.frame)-CGRectGetMaxX(self.cameraButton.frame)-20,CGRectGetHeight(self.bounds)-10);
        _contentView.animateHeightChange = NO;
        _contentView.font=[UIFont systemFontOfSize:18];
        _contentView.layer.cornerRadius=5;
        //_contentView.textAlignment=NSTextAlignmentCenter;
        _contentView.layer.masksToBounds=YES;
        //给文本框加上边框
       // _contentView.textContainerInset=UIEdgeInsetsMake(0, 0, -25, 0);
        _contentView.layer.borderWidth=1;
        _contentView.layer.borderColor=[UIColor colorFromHexCode:@"abadb2"].CGColor;
        _contentView.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
        
    }
    return _contentView;
}

-(UIButton*)cameraButton{
    if (!_cameraButton) {
        _cameraButton=[[UIButton alloc]init];
        
        self.cameraButton.frame=CGRectMake(10,5, 39, CGRectGetHeight(self.bounds)-10);
        
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"kf_button_add"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

-(UIButton*)sendButton{
    if (!_sendButton) {
        _sendButton=[[UIButton alloc]init];
        _sendButton.bounds=CGRectMake(0, 0, 60, 40);
         self.sendButton.frame=CGRectMake(CGRectGetWidth(self.bounds)-CGRectGetWidth(self.sendButton.bounds)-10, 5, CGRectGetWidth(self.sendButton.bounds), CGRectGetHeight(self.bounds)-10);
        _sendButton.layer.cornerRadius=5;
        _sendButton.layer.masksToBounds=YES;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.backgroundColor=[UIColor colorFromHexCode:@"41aaf2"];
        [_sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}


#pragma mark--button action


-(void)sendButtonPressed:(UIButton*)btn{
  
}

- (void)cameraButtonPressed:(UIButton*)btn{

}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark- HPGrowingTextViewDelegate

- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView{

    return YES;
}
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height{
//    CGRect rect = self.frame;
//    rect.size.height = height+10
//    ;
//    self.frame = rect;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(interactiveView:willChangeHeight:)]) {
          [_delegate interactiveView:self willChangeHeight:height+10];
    }
}
//- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    return YES;
//}

- (void)setHideCameraButton:(BOOL)hideCameraButton
{
    _hideCameraButton = hideCameraButton;
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.contentView.placeholder = placeholder;
}

@end
