//
//  ASCSlideModalVC.m
//  Pods
//
//  Created by Alex Chase on 3/17/16.
//
//

#import "ASCSlideModalVC.h"

@interface ASCSlideModalVC ()
@property (nonatomic, copy) void(^completionBlock)();
@property (nonatomic,strong)ASCSlideView *slideView;
@property (nonatomic,assign)CGFloat lastPoint;
@end

@implementation ASCSlideModalVC


-(instancetype)initWithCompletionBlock:(void(^)())completetionBlock{
    self = [super init];
    if (self) {
        self.completionBlock = completetionBlock;
        _slideView = [[ASCSlideView alloc]initWithContentView:nil];
        _slideView.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan)];
        [_slideView addGestureRecognizer:_slideView.pan];
        [self.view addSubview:_slideView];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch =[touches anyObject];
    if(![[touch view] isKindOfClass:[ASCSlideView class]]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)handlePan{
    
    switch (_slideView.pan.state) {
            
        case UIGestureRecognizerStateBegan:
            [self moveView];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self moveView];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self panComplete];
            break;
            
        case UIGestureRecognizerStateCancelled:
            [self panComplete];
            break;
            
        default:
            break;
    }
}

-(void)moveView{
    
    CGFloat vy = [_slideView.pan velocityInView:_slideView].y;
    NSLog(@"%f",vy);
    if (fabs(vy) <= 1000.f) {
        CGFloat dy = [_slideView.pan translationInView:_slideView].y;
        _slideView.frame = CGRectMake(CGRectGetMinX(_slideView.frame),
                                      CGRectGetMinY(_slideView.originalFrame)+dy,
                                      CGRectGetWidth(_slideView.frame),
                                      CGRectGetHeight(_slideView.frame));
    }
    else{
        [self animateSlideOffScreenUp:(vy<0)];
    }
}



-(void)panComplete{
    if (CGRectGetMidY(_slideView.frame)<=0  || CGRectGetMidY(_slideView.frame)>=SCREEN_HEIGHT) {
        [self dismissSlideVC];
    }
    else{
        [self animateSlideToOrigin];
    }
}

-(void)animateSlideToOrigin{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_slideView setFrame:_slideView.originalFrame];
    } completion:nil];
}


-(void)animateSlideOffScreenUp:(BOOL)shouldSlideUp{
    
    CGFloat finalY = shouldSlideUp ? -CGRectGetHeight(_slideView.frame):SCREEN_HEIGHT+CGRectGetHeight(_slideView.frame);
    CGRect finalFrame = CGRectMake(CGRectGetMinX(_slideView.frame),
                                   finalY,
                                   CGRectGetWidth(_slideView.frame),
                                   CGRectGetHeight(_slideView.frame));
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [_slideView setFrame:finalFrame];
    } completion:^(BOOL finished) {
        __weak typeof(self)weakSelf = self;
        if (finished) {
            [weakSelf dismissSlideVC];
        }
    }];
}

-(void)dismissSlideVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end


@interface ASCSlideView()
@end
@implementation ASCSlideView
-(instancetype)initWithContentView:(UIView *)contentView{
    
    CGFloat slideWidth = SCREEN_WIDTH-(2*DEFAULT_SPACING);
    CGFloat slideHeight = 425;
    CGFloat slideOrigin = (SCREEN_HEIGHT-slideHeight)/2;
    
    self = [super initWithFrame:CGRectMake(DEFAULT_SPACING, slideOrigin, slideWidth, slideHeight)];
    if (self) {
        _originalFrame = self.frame;
        self.backgroundColor =[[ASCStyleManager sharedStyle] successColor];
        self.clipsToBounds = NO;
    }
    return self;
}




@end
