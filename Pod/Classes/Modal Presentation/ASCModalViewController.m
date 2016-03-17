//
//  ASCModalViewController.m
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import "ASCModalViewController.h"
#import "ASCPresentationController.h"

@interface ASCModalViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic,strong)ASCPresentationController *presentationController;
@end

@implementation ASCModalViewController

#pragma mark - UIViewController Overrides

-(instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if(self.hidesStatusBar) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
    
    else if([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.hidesStatusBar) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }
}



#pragma mark - UIViewControllerTransitioningDelegate methods

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    self.presentationController = [[ASCPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return self.presentationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.presentationController;
}




@end
