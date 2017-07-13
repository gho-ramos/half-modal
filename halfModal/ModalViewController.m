//
//  ModalViewController.m
//  halfModal
//
//  Created by Guilherme on 7/10/17.
//  Copyright © 2017 Guilherme Ramos. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = ({
        CGRect frame = self.view.frame;
        frame.size.height = frame.size.height / 2;
        frame;
    });
    [self.cancelButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)]];
}

-(void)viewWillAppear:(BOOL)animated {
}

-(void)adjustLayout {
}

-(void)tapOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
