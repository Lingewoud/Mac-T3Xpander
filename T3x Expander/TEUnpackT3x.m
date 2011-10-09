//
//  TEUnpackT3x.m
//  T3x Expander
//
//  Created by Pim Snel on 09-10-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import "TEUnpackT3x.h"

@implementation TEUnpackT3x

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (void)unpackT3xFile:(NSString *)filePath
{
    NSLog(@"Unpacking %@",filePath);
    //	set phpcommand to "/usr/bin/php -c" & hiddeninipath & " " & hiddenscriptpath & " " & full_path & " " & full_path_new
    
    NSString *expandt3xPath = [NSString stringWithFormat:@"%@/Contents/Resources/expandt3x",[[NSBundle mainBundle] bundlePath]];
    NSLog(@"expandt3xPath: %@",expandt3xPath);
    
    NSString * phpExec = @"/usr/bin/php";
    NSString * phpIniPath = [NSString stringWithFormat:@"%@/php.ini",expandt3xPath];
    NSString * phpScriptPath = [NSString stringWithFormat:@"%@/expandt3x.php",expandt3xPath];

    NSString * newOutputPath = [filePath stringByDeletingPathExtension];
    
    NSTask *phpProcess = [[NSTask alloc] init];    
    [phpProcess setCurrentDirectoryPath:expandt3xPath];
    [phpProcess setLaunchPath: phpExec];
    [phpProcess setArguments: [NSArray arrayWithObjects:@"-c",phpIniPath,phpScriptPath,filePath,newOutputPath,nil]];    
    [phpProcess launch];        
    
    [phpProcess waitUntilExit];
    int status = [phpProcess terminationStatus];
    
    if (status == 0)
        NSLog(@"Task succeeded.");
    else
        NSLog(@"Task failed.");
    
    [phpProcess release];
}

@end
