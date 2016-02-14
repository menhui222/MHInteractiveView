//
//  InteractiveView.h
//  MHInteractiveView
//
//  Created by 孟辉 on 15/11/25.
//  Copyright © 2016年 iasku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"



@protocol InteractiveViewProtocol;
@interface InteractiveView : UIView<HPGrowingTextViewDelegate>

@property (strong,nonatomic) UIButton * cameraButton;
@property (strong,nonatomic) HPGrowingTextView * contentView;
@property (strong,nonatomic) UIButton * sendButton;
@property (strong,nonatomic) UIImage * image;
@property (weak,nonatomic) id<InteractiveViewProtocol>  delegate;

@property (nonatomic, assign, getter=isHideCameraButton) BOOL hideCameraButton;

@property (nonatomic, strong) NSString *placeholder;

@end
@protocol InteractiveViewProtocol <NSObject>

-(void)messageWillSend:(UIImage*)sendImage text:(NSString*)sendText;
- (void)interactiveView:(InteractiveView *)interactiveView willChangeHeight:(CGFloat)height;

@end