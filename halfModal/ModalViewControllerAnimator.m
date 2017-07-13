//
//  ModalViewControllerAnimator.m
//  halfModal
//
//  Created by Guilherme on 7/10/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "ModalViewControllerAnimator.h"

#define kDefaultTransitionDuration 0.5

@implementation ModalViewControllerAnimator



-(UIVisualEffectView*)dimmingViewWithFrame:(CGRect)frame {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = frame;
    
    return blurEffectView;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kDefaultTransitionDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([destinationViewController isBeingPresented]) {
        [self animatePresentation:transitionContext];
    } else {
        [self animateDismissal:transitionContext];
    }
}

-(void)animatePresentation:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *sourceViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ModalViewController *destinationViewController = (ModalViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    sourceViewController.dimmingView = [[UIView alloc] initWithFrame:containerView.frame];
    
    [containerView addSubview:sourceViewController.dimmingView];
    [sourceViewController beginAppearanceTransition:NO animated:YES];
    
    destinationViewController.view.frame = ({
        CGRect frame = destinationViewController.view.frame;
        frame.origin.y = sourceViewController.view.frame.size.height;
        frame;
    });
    
    destinationViewController.view.layer.borderWidth = 1;
    destinationViewController.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [sourceViewController.dimmingView addSubview:destinationViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        destinationViewController.view.frame = ({
            CGRect frame = destinationViewController.view.frame;
            frame.origin.y = sourceViewController.view.frame.size.height / 2;
            frame;
        });
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
        [sourceViewController endAppearanceTransition];
    }];
}

-(void)animateDismissal:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *destinationViewController = (ViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        destinationViewController.dimmingView.frame = ({
            CGRect frame = destinationViewController.dimmingView.frame;
            frame.origin.y = destinationViewController.dimmingView.frame.size.height;
            frame;
        });
    } completion:^(BOOL finished) {
        [destinationViewController.dimmingView removeFromSuperview];
        destinationViewController.dimmingView = nil;
        [transitionContext completeTransition:finished];
    }];
}

@end
