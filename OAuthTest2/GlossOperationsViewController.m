//
//  GlossOperationsViewController.m
//  OAuthTest2
//
//  Created by Stan on 17.05.13.
//  Copyright (c) 2013 GLoSS. All rights reserved.
//

#import "GlossOperationsViewController.h"

@interface GlossOperationsViewController ()

@end

@implementation GlossOperationsViewController
- (IBAction)showAccount:(id)sender {
    NSLog(@"%@", ((GlossOperationsParameters*)self.childViewControllers[0]).account.textLabel.text);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
