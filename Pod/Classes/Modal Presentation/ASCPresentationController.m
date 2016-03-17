//
//  ASCPresentationController.m
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import "ASCPresentationController.h"
#import "UIImage+ImageEffects.h"

@interface ASCPresentationController()
@property (nonatomic, strong) UIImageView *blurredImageView;
@end


@implementation ASCPresentationController

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if([self.containerView.subviews containsObject:self.presentedView]) {
        
        //dismissing
        NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:transitionDuration animations:^{
            
            self.blurredImageView.alpha = 0.0f;
            self.presentedView.alpha = 0.0f;
            
        } completion:^(BOOL finished){
            
            [transitionContext completeTransition:YES];
        }];
    }
    else {
        
        //presenting
        self.presentedView.alpha = 0.0f;
        self.presentedView.transform = CGAffineTransformMakeScale(1.03f, 1.03f);
        [self.containerView addSubview:self.presentedView];
        
        NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:transitionDuration animations:^{
            
            self.presentedView.alpha = 1.0f;
            self.presentedView.transform = CGAffineTransformIdentity;
            self.blurredImageView.alpha = 1.0f;
            
        } completion:^(BOOL finished){
            
            [transitionContext completeTransition:YES];
        }];
    }
}

#pragma mark - Presentation Controller

- (UIImageView *)blurredImageView {
    
    if(!_blurredImageView) {
        
        _blurredImageView = [[UIImageView alloc] init];
    }
    
    return _blurredImageView;
}

- (UIImage *)blurredScreenshotImageFromView:(UIView  *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIColor *tintColor = [UIColor colorWithWhite:1.000 alpha:0.900];
    return [image applyBlurWithRadius:14.0f tintColor:tintColor saturationDeltaFactor:1.8f maskImage:nil];
}

- (void)presentationTransitionWillBegin {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    self.blurredImageView.image = [self blurredScreenshotImageFromView:self.presentingViewController.view];
    self.blurredImageView.frame = self.containerView.bounds;
    self.blurredImageView.alpha = 0.0f;
    
    [self.containerView addSubview:self.blurredImageView];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    
}

- (void)dismissalTransitionWillBegin {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    
    [self.blurredImageView removeFromSuperview];
}
@end
