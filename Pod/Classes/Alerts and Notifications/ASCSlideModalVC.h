//
//  ASCSlideModalVC.h
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import "ASCModalViewController.h"
#import "ASCPageView.h"



@interface ASCSlideModalVC : ASCModalViewController
-(instancetype)initWithCompletionBlock:(void(^)())completetionBlock;
@property (nonatomic,strong)NSArray *slides;

@end


@interface ASCSlideView: ASCPageView
-(instancetype)initWithContentView:(UIView *)contentView;
@property(nonatomic,strong)UIPanGestureRecognizer *pan;
@property (nonatomic,assign)CGRect originalFrame;

@end
