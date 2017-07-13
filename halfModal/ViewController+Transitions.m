//
//  ModalViewController+Transitions.m
//  halfModal
//
//  Created by Guilherme on 7/10/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import "ModalViewControllerAnimator.h"
#import "ViewController+Transitions.h"

@implementation ViewController (Transitions)

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ModalViewControllerAnimator new];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ModalViewControllerAnimator new];
}

@end
