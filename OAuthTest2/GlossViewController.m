//
//  GlossViewController.m
//  OAuthTest2
//
//  Created by Stan on 02.05.13.
//  Copyright (c) 2013 GLoSS. All rights reserved.
//
// @see http://code.google.com/p/gtm-oauth/wiki/GTMOAuthIntroduction#Signing_in_to_Services
// Also look at Podfile

#import "GlossViewController.h"
//#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuthViewControllerTouch.h"

@interface GlossViewController ()

@end

@implementation GlossViewController

static NSString *const kKeychainItemName = @"ZenMoney Token";

//NSString *kMyClientID = @"1637801226.apps.googleusercontent.com";     // pre-assigned by service
//NSString *kMyClientSecret = @"GXmpUXZRbiRGBxL8_tCuZQzD"; // pre-assigned by service
//
//NSString *scope = @"https://www.googleapis.com/auth/plus.me"; // scope for Google+ API

NSString *kMyConsumerKey = @"gc08df66175eddde146794b633f71f";     // pre-assigned by service
NSString *kMyConsumerSecret = @"913e2c4933"; // pre-assigned by service
NSString *kMyAppName = @"Test1";

- (IBAction)addNewOperation:(id)sender {
    NSNull *nullValue = [NSNull null];
    NSDictionary *newDict = @{
                              @"account_income":@363901,
                              @"account_outcome":@363901,
                              @"date":@"2013-05-04",
                              @"income":@"0.0000",
                              @"outcome":self.operationSum.text,
                              @"category":@0,
                              @"payee":@"1",
                              @"comment":@"2",
                              @"instrument_income":@2,
                              @"instrument_outcome":@2,
                              @"price":nullValue,
                              @"static_id":nullValue,
                              @"changed":@"2013-05-04 11:20:03.51137+04",
                              @"payback_reminder_marker":nullValue,
                              @"type_income":@"cash",
                              @"type_outcome":@"cash",
                              @"direction":@-1,
                              @"marker":nullValue,
                              @"imported":nullValue,
                              @"inbalance_income":@YES,
                              @"inbalance_outcome":@YES,
                              @"bankid_income":nullValue,
                              @"bankid_outcome":nullValue,
                              @"hold":nullValue,
                              @"tag_groups":@[@439685],
                              @"payee_inflected":@[]
                              };
    if(![NSJSONSerialization isValidJSONObject:newDict]) {
        NSLog(@"Cannot convert to JSON");
        return;
    }
    //NSError *error = nil;
    NSData *jsonSend = [NSJSONSerialization dataWithJSONObject:newDict options:nil error:nil];
    NSString *myString = [[NSString alloc] initWithData:jsonSend encoding:NSUTF8StringEncoding];
    //NSLog(myString);
    
    [self awakeFromNib];
    if(![_auth canAuthorize]) {
        NSLog(@"You are not authorized");
        return;
    }
    
    NSString *urlStr = @"http://api.zenmoney.ru/v2/transaction/";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:jsonSend];
    [_auth authorizeRequest:request];
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    // TODO Check for response, error, etc.
    
    NSString *str = [[NSString alloc] initWithData:data
                                           encoding:NSNonLossyASCIIStringEncoding];
    NSLog(str);
}

GTMOAuthAuthentication *_auth;

//- (GTMOAuth2Authentication *)zenMoneyAuth {
//    
//    NSURL *tokenURL = [NSURL URLWithString:@"dddhttp://api.zenmoney.ru/oauth/request_token"];
//    
//    // We'll make up an arbitrary redirectURI.  The controller will watch for
//    // the server to redirect the web view to this URI, but this URI will not be
//    // loaded, so it need not be for any actual web page.
//    NSString *redirectURI = @"http://www.google.com/OAuthCallback";
//    
//    GTMOAuth2Authentication *auth;
//    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:@"Test123"
//                                                             tokenURL:tokenURL
//                                                          redirectURI:redirectURI
//                                                             clientID:kMyClientID
//                                                         clientSecret:kMyClientSecret];
//    auth.shouldAuthorizeAllRequests = YES;
//    return auth;
//}

- (GTMOAuthAuthentication *)myCustomAuth {
    GTMOAuthAuthentication *auth;
    auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                        consumerKey:kMyConsumerKey
                                                         privateKey:kMyConsumerSecret];
    
    // setting the service name lets us inspect the auth object later to know
    // what service it is for
    auth.serviceProvider = @"Custom Auth Service";
    
    return auth;
}

- (IBAction)onOAuthClick:(id)sender {
//    GTMOAuth2Authentication *auth = [self zenMoneyAuth];
//    
//    NSURL *authURL = [NSURL URLWithString:@"http://api.zenmoney.ru/access/?mobile"];
//    
//    GTMOAuth2ViewControllerTouch *viewController;
//    viewController = [[[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth
//                                                                  authorizationURL:authURL
//                                                                  keychainItemName:kKeychainItemName
//                                                                          delegate:self
//                                                                  finishedSelector:@selector(viewController:finishedWithAuth:error:)] autorelease];
//    
//    [[self navigationController] pushViewController:viewController
//                                           animated:YES];
    
    NSURL *requestURL = [NSURL URLWithString:@"http://api.zenmoney.ru/oauth/request_token"];
    NSURL *accessURL = [NSURL URLWithString:@"http://api.zenmoney.ru/oauth/access_token"];
    NSURL *authorizeURL = [NSURL URLWithString:@"http://api.zenmoney.ru/access/?mobile"];
    NSString *scope = @"http://example.com/scope";
    
    [self awakeFromNib];
    
    if([_auth canAuthorize]) {
        NSLog(@"Already authorized");
        return;
    }
    
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    
    // set the callback URL to which the site should redirect, and for which
    // the OAuth controller should look to determine when sign-in has
    // finished or been canceled
    //
    // This URL does not need to be for an actual web page
    [auth setCallback:@"http://www.google.com/OAuthCallback"];
    
    // Display the autentication view
    GTMOAuthViewControllerTouch *viewController;
    viewController = [[GTMOAuthViewControllerTouch alloc] initWithScope:nil
                                                                language:nil
                                                         requestTokenURL:requestURL
                                                       authorizeTokenURL:authorizeURL
                                                          accessTokenURL:accessURL
                                                          authentication:auth
                                                          appServiceName:kMyAppName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController
                                           animated:YES];
    
}

- (void)viewController:(GTMOAuthViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuthAuthentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        NSLog(@"Authentication failed");
    } else {
        if (auth.canAuthorize){
            NSLog(@"Auth succeded");
        }
    }
}

- (void) setAuthentication:(GTMOAuthAuthentication *)auth {
    _auth = auth;
}

- (void)awakeFromNib {
    // Get the saved authentication, if any, from the keychain.
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    if (auth) {
        BOOL didAuth = [GTMOAuthViewControllerTouch authorizeFromKeychainForName:kMyAppName
                                                                  authentication:auth];
        // if the auth object contains an access token, didAuth is now true
    }
    
    // retain the authentication object, which holds the auth tokens
    //
    // we can determine later if the auth object contains an access token
    // by calling its -canAuthorize method
    [self setAuthentication:auth];
}
- (IBAction)doRequest:(void *)sender {
    [self awakeFromNib];
    if(![_auth canAuthorize]) {
        NSLog(@"You are not authorized");
        return;
    }
    
    NSString *urlStr = @"http://api.zenmoney.ru/v1/account/";
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [_auth authorizeRequest:request];
    
    // Note that for a request with a body, such as a POST or PUT request, the
    // library will include the body data when signing only if the request has
    // the proper content type header:
    //
    //   [request setValue:@"application/x-www-form-urlencoded"
    //  forHTTPHeaderField:@"Content-Type"];
    
    // Synchronous fetches like this are a really bad idea in Cocoa applications
    //
    // For a very easy async alternative, we could use GTMHTTPFetcher
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (data) {
        // API fetch succeeded
        NSString *str = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
        
        // Working with JSON
        // @see http://www.raywenderlich.com/5492/working-with-json-in-ios-5
        // @see http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data //1
                              
                              options:kNilOptions
                              error:&error];
        
        NSArray* latestLoans = [json objectForKey:@"id"]; //2
        
        NSLog(@"id: %@", json); //3
        //NSLog(@"API response: %@", str);
    } else {
        // fetch failed
        NSLog(@"API fetch error: %@", error);
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
