//
//  T3x_ExpanderAppDelegate.m
//  T3x Expander
//
//  Created by Pim Snel on 11-04-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import "T3x_ExpanderAppDelegate.h"

@implementation T3x_ExpanderAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}

- (IBAction)openTypo3ExtensionReposotory:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.typo3.org/extensions/"]];
}

- (IBAction)openT3ExpanderWebsite:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.lingewoud.nl/t3expander"]];
}

@end
