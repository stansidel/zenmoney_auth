//
//  GlossViewController.m
//  OAuthTest2
//
//  Created by Stan on 02.05.13.
//  Copyright (c) 2013 GLoSS. All rights reserved.
//

#import "GlossViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"

@interface GlossViewController ()

@end

@implementation GlossViewController

static NSString *const kKeychainItemName = @"OAuth2 Sample: Google+";

NSString *kMyClientID = @"1637801226.apps.googleusercontent.com";     // pre-assigned by service
NSString *kMyClientSecret = @"GXmpUXZRbiRGBxL8_tCuZQzD"; // pre-assigned by service

NSString *scope = @"https://www.googleapis.com/auth/plus.me"; // scope for Google+ API

//NSString *kMyClientID = @"gf3b54f81de3c418c73bded41ce6f5";     // pre-assigned by service
//NSString *kMyClientSecret = @"b5f0764b72"; // pre-assigned by service
//
//NSString *scope = @"http://api.zenmoney.ru/oauth/request_token"; // scope for Google+ API

- (IBAction)onOAuthClick:(id)sender {
    NSLog(@"Starting auth");
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[[GTMOAuth2ViewControllerTouch alloc] initWithScope:scope
                                                                 clientID:kMyClientID
                                                             clientSecret:kMyClientSecret
                                                         keychainItemName:kKeychainItemName
                                                                 delegate:self
                                                         finishedSelector:@selector(viewController:finishedWithAuth:error:)] autorelease];
    
    [[self navigationController] pushViewController:viewController
                                           animated:YES];
    
    NSLog(@"Auth end");
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        NSLog(@"Authentication failed");
    } else {
        if (auth.canAuthorize){
            NSLog(auth.userEmail);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
