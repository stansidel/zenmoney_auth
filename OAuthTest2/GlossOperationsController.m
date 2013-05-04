//
//  GlossOperationsController.m
//  OAuthTest2
//
//  Created by Stan on 04.05.13.
//  Copyright (c) 2013 GLoSS. All rights reserved.
//

#import "GlossOperationsController.h"

@interface GlossOperationsController ()

@end

@implementation GlossOperationsController

- (IBAction)onTouch:(id)sender {
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.myTextField.inputView;
    self.myTextField.text = [NSString stringWithFormat:@"%@",picker.date];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.myTextField setInputView:datePicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
