//
//  BottomSheet.h
//  halfModal
//
//  Created by Guilherme on 7/11/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultBottomSheetAnimationDuration 0.4

#ifndef BS_INSTANCETYPE
    #if __has_feature(objc_instancetype)
        #define BS_INSTANCETYPE instancetype
    #else
        #define BS_INSTANCETYPE id
    #endif
#endif

typedef NS_ENUM(NSUInteger, BottomSheetAnimation) {
    BottomSheetAnimationTypeSlideUp,
    BottomSheetAnimationTypeSlideDown,
};

typedef void (^BottomSheetCompletionBlock)(id param);

@interface BottomSheet : UIView

/**
 * Removes the BottomSheet view from its parent view when hidden.
 * Default: NO.
 */
@property (assign) BOOL removeFromSuperViewOnHide;

/**
 * The animation type that should be used when the HUD is shown and hidden.
 *
 * @see BottomSheetAnimation
 */
@property (assign) BottomSheetAnimation animationType;

/**
 * Indicates wether the BottomSheet View is visible or hidden.
 * Default: NO.
 */
@property (assign) BOOL isVisible;

/**
 * Determine the origin of the Bottom Sheet view.
 * Default: 0.0.
 */
@property (assign) CGFloat bsOrigin;

/**
 * Determine the default size of the Bottom Sheet view.
 * Default: 0.0.
 */
@property (assign) CGSize bsSize;

/**
 * Determine if the Bottom Sheet view will have a visible shadow.
 * Default: YES;
 */
@property (assign) BOOL hasShadows;

/**
 * A block that gets called after the The Bottom sheet hides.
 */
@property (copy) BottomSheetCompletionBlock completionBlock;

+(BS_INSTANCETYPE)showCustomBottomSheetWithView:(UIView*)view andFrame:(CGRect)frame onViewController:(UIViewController*)viewController completion:(BottomSheetCompletionBlock)completion;

+(void)hideCustomBottomSheetOnViewController:(UIViewController*)viewController;

+(BS_INSTANCETYPE)bottomSheetForView:(UIView*)view;
@end
