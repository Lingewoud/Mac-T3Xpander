//
//  T3x_ExpanderAppDelegate.m
//  T3x Expander
//
//  Created by Pim Snel on 11-04-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import "T3x_ExpanderAppDelegate.h"
#import "TEUnpackT3x.h"

@implementation T3x_ExpanderAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}


- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
    //NSLog(@"filename:%@",filename);
    
    if ([[filename pathExtension] isEqual:@"t3x"]){
        [TEUnpackT3x unpackT3xFile:filename];
        return YES;
    } else {
        return NO;
    }
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
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.lapp5.com"]];
}


- (IBAction)sendFileButtonAction:(id)sender{
    
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:YES];
    
    // Enable the selection of directories in the dialog.
    [openDlg setCanChooseDirectories:NO];
    
    [openDlg setAllowsMultipleSelection:NO];

    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    if ( [openDlg runModalForDirectory:nil file:nil] == NSOKButton )
    {
        // Get an array containing the full filenames of all
        // files and directories selected.
        NSArray* files = [openDlg filenames];
        
        // Loop through all the files and process them.
        for( int i = 0; i < [files count]; i++ )
        {
            NSString* fileName = [files objectAtIndex:i];
            //NSLog(@"f:%@",fileName);
            
            if ([[fileName pathExtension] isEqual:@"t3x"]){
                [TEUnpackT3x unpackT3xFile:fileName];
            }

        }
    }
    
}

@end
