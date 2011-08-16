//
//  UISpecsAppDelegate.h
//  UISpecs
//
//  Created by Jeremy Lightsmith on 8/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UISpecsViewController;

@interface UISpecsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISpecsViewController *viewController;

@end
