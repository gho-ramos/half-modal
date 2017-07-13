//
//  CustomView.h
//  halfModal
//
//  Created by Guilherme on 7/12/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
+(NSString*)nibName;

+(UINib*)nib;
@end
