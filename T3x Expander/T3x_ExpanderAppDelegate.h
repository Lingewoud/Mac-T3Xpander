//
//  T3x_ExpanderAppDelegate.h
//  T3x Expander
//
//  Created by Pim Snel on 11-04-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface T3x_ExpanderAppDelegate : NSObject <NSApplicationDelegate> {

@private
    NSWindow *window;
}

- (IBAction)openTypo3ExtensionReposotory:(id)sender;
- (IBAction)openT3ExpanderWebsite:(id)sender;
- (IBAction)sendFileButtonAction:(id)sender;


@property (assign) IBOutlet NSWindow *window;

@end
