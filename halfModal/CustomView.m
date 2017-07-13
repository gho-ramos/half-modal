//
//  CustomView.m
//  halfModal
//
//  Created by Guilherme on 7/12/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void) setupView {
    UIView *view = [self viewFromNib];
    view.frame = [self bounds];
    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    [self addSubview:view];
}


- (UIView *) viewFromNib {
    NSBundle *mainBundle = [NSBundle mainBundle];
    UINib *nib = [UINib nibWithNibName:[CustomView nibName] bundle:mainBundle];
    UIView *view = (UIView*)[[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

+ (NSString *) nibName {
    return NSStringFromClass([self class]);
}

+ (UINib *) nib {
    return [UINib nibWithNibName:[self nibName] bundle:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
