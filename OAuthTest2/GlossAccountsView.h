//
//  GlossAccountsView.h
//  OAuthTest2
//
//  Created by Stan on 13.05.13.
//  Copyright (c) 2013 GLoSS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OperationsViewDelegate;

@interface GlossAccountsView : UITableViewController
@property NSString* account;
@property (assign) id<OperationsViewDelegate> delegate;
@end

@protocol OperationsViewDelegate
-(void)chosenAccount:(NSString*)account :(GlossAccountsView*)fromView;
@end