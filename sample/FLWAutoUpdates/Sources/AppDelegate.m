//
//  AppDelegate.m
//  FLWAutoUpdates
//
//  Created by Created by Hung Q. Truong on 10/17/19.
//  Copyright © 2019 Floware. All rights reserved.
//

#import "AppDelegate.h"
#import <Sparkle/Sparkle.h>

@interface AppDelegate ()

@end

@implementation AppDelegate {
    SUUpdater *_updater;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _updater = [SUUpdater sharedUpdater];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)checkForUpdates:(id)sender
{
    [_updater checkForUpdates:nil];
}

@end
