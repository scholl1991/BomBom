//
//  BBAppDelegate.m
//  BomBom
//
//  Created by Alexey Kolmyk on 16.12.13.
//  Copyright (c) 2013 SonnyBlack. All rights reserved.
//

#import "BBAppDelegate.h"

#import "QBClient.h"
#import "BBSpinnerView.h"

@implementation BBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
		
	[self.window makeKeyAndVisible];
	
	[BBSpinnerView showSpinner];
	[[QBClient shared] createSessionQithBlock:^(BOOL isCreated, NSError *anError) {
		if (isCreated){
			[BBSpinnerView hideSpinner];
		}
		if (anError) {
			[QBClient showAlertForError:anError];
		}
		
	}];

	
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	BOOL isSessionValid = [[QBClient shared] isCurrentSessionValid];
	if (isSessionValid == NO) {
		[[QBClient shared] createExtendedSessinWithBlock:^(BOOL isCreated, NSError *anError) {
			if (anError) {
				[QBClient showAlertForError:anError];
			}
		}];
	}
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end