//
//  UINavigationController+ASCNavigation.m
//  Pods
//
//  Created by Alex Chase on 3/16/16.
//
//

#import "UINavigationController+ASCNavigation.h"

@implementation UINavigationController (ASCNavigation)
+(instancetype)navigationControllerToPresentVC:(UIViewController *)vc{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    navigationController.navigationBarHidden = YES;
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    navigationController.transitioningDelegate = (UIViewController <UIViewControllerTransitioningDelegate> *) vc;
    return navigationController;
}
@end
