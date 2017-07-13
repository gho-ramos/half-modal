//
//  BottomSheet.m
//  halfModal
//
//  Created by Guilherme on 7/11/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import "BottomSheet.h"

@interface BottomSheet() {
    BOOL animate;
    BOOL finished;
}
@end

@implementation BottomSheet
@synthesize isVisible;


#pragma mark - Static methods

+(BS_INSTANCETYPE)showCustomBottomSheetWithView:(UIView *)view andFrame:(CGRect)frame onViewController:(UIViewController *)viewController completion:(BottomSheetCompletionBlock)completion{
    BottomSheet *bottomSheetView = [self bottomSheetForView:viewController.view];
    
    if (bottomSheetView == nil) {
        CGRect newFrame = [self calculateVisibleFrameOfView:viewController.view frame:frame];
        bottomSheetView = [[self alloc] initWithFrame:newFrame];
        bottomSheetView.removeFromSuperViewOnHide = YES;
        bottomSheetView.completionBlock = completion;
        [bottomSheetView addSubview:view];
        [viewController.view addSubview:bottomSheetView];
        [bottomSheetView show:YES];
    }
    
    return bottomSheetView;
}

+(void)hideCustomBottomSheetOnViewController:(UIViewController *)viewController {
    BottomSheet *bottomSheetView = [self bottomSheetForView:viewController.view];
    if (bottomSheetView != nil) {
        bottomSheetView.removeFromSuperViewOnHide = YES;
        [bottomSheetView hide:YES];
    }
}

+(BS_INSTANCETYPE)bottomSheetForView:(UIView*)view {
    NSEnumerator *subviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviews) {
        if([subview isKindOfClass:[self class]]) {
            return (BottomSheet*)subview;
        }
    }
    return nil;
}

#pragma mark - Lifecycle operations 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.removeFromSuperViewOnHide = NO;
        self.bsOrigin = 0;
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 1;
        self.isVisible = NO;
        
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowOpacity = 0.4;
        self.layer.masksToBounds = NO;
    }
    return self;
}

- (instancetype)initWithView:(UIView*)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

#pragma mark - Internal show, hide and done operations

-(void)show:(BOOL)animated {
    NSAssert([NSThread isMainThread], @"MBProgressHUD needs to be accessed on the main thread.");
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self setNeedsDisplay];
    animate = animated;
    if (!isVisible) {
        if(animate) {
            [UIView animateWithDuration:kDefaultBottomSheetAnimationDuration animations:^{
                self.frame = ({
                    CGRect frame = self.frame;
                    frame.origin.y = frame.origin.y - self.frame.size.height;
                    frame;
                });
            }];
        } else {
            self.frame = ({
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y - self.frame.size.height;
                frame;
            });
        }
    }
}

-(void)hide:(BOOL)animated {
    NSAssert([NSThread isMainThread], @"BottomSheetView needs to be accessed on the main thread.");
    animate = animated;
    if (animate) {
        [UIView animateWithDuration:kDefaultBottomSheetAnimationDuration animations:^{
            self.frame = ({
                CGRect frame = self.frame;
                UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
                frame.origin.y = mainWindow.frame.size.height;
                frame;
            });
        } completion:^(BOOL finished) {
            [self done];
        }];
    } else {
        [self done];
    }
}

-(void)done {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    finished = YES;
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    if (self.removeFromSuperViewOnHide) {
        [self removeFromSuperview];
    }
}

#pragma mark - Utility

+(CGRect)calculateVisibleFrameOfView:(UIView*)view frame:(CGRect)frame {
    CGFloat keyboardGap = view.bounds.size.height - frame.origin.y;
    CGRect _frame = CGRectMake(view.bounds.origin.x, frame.origin.y, view.bounds.size.width, keyboardGap);
    return _frame;
}
@end
