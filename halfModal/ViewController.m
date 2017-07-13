//
//  ViewController.m
//  halfModal
//
//  Created by Guilherme on 7/10/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import "CustomView.h"
#import "BottomSheet.h"
#import "ViewController.h"
#import "ModalViewController.h"
#import "ViewController+Transitions.h"

@interface ViewController () <UITextFieldDelegate> {
    UITextField *activeTextField;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    activeTextField = textField;
    return YES;
}

-(void)keyboardShown:(NSNotification*)notification {
    [self.view setNeedsDisplay];
    CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // margins
    CustomView *customView = [[CustomView alloc] initWithFrame:CGRectMake(16, 8, self.view.bounds.size.width - 32, self.view.bounds.size.height - frame.origin.y)];
    [BottomSheet showCustomBottomSheetWithView:customView andFrame:frame onViewController:self completion:^(id param) {
        self.textField.text = customView.textField.text;
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [BottomSheet hideCustomBottomSheetOnViewController:self];
}

-(void)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)startTransition:(id)sender {
    ModalViewController *modalViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ModalViewController"];
    
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:modalViewController animated:YES completion:nil];
}
@end
