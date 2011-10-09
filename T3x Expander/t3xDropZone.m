//
//  t3xDropZone.m
//  T3x Expander
//
//  Created by Pim Snel on 12-04-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import "t3xDropZone.h"


@implementation t3xDropZone

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];

    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSTIFFPboardType, NSFilenamesPboardType, nil]];
    
    
    
    return self;
}

- (void)dealloc
{
    [self unregisterDraggedTypes];

    [super dealloc];
}

- (void)drawRect:(NSRect)rect
{
    NSRect ourBounds = [self bounds];
    NSImage *image = [self image];
    [super drawRect:rect];
    [image compositeToPoint:(ourBounds.origin) operation:NSCompositeSourceOver];

}

- (void)setImage:(NSImage *)newImage
{
    NSImage *temp = [newImage retain];
    [_ourImage release];
    _ourImage = temp;
}

- (NSImage *)image
{
    return _ourImage;
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
        == NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
        //are offering
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
        //to tell them we aren't interested
        return NSDragOperationNone;
    }
}


- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
        == NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
        //are offering
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
        //to tell them we aren't interested
        return NSDragOperationNone;
    }
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *paste = [sender draggingPasteboard];
    
    //gets the dragging-specific pasteboard from the sender
    NSArray *types = [NSArray arrayWithObjects:NSTIFFPboardType, NSFilenamesPboardType, nil];
    
    //a list of types that we can accept
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
    
    if (nil == carriedData)
    {
        //the operation failed for some reason
        NSRunAlertPanel(@"Paste Error", @"Sorry, but the past operation failed", nil, nil, nil);
        return NO;
    }
    else
    {
        //the pasteboard was able to give us some meaningful data
        if ([desiredType isEqualToString:NSTIFFPboardType])
        {
            //we failed for some reason
            NSRunAlertPanel(@"File Reading Error", 
                            [NSString stringWithFormat:
                             @"Please dropa t3x file"], nil, nil, nil);
            return NO;
        }
        else if ([desiredType isEqualToString:NSFilenamesPboardType])
        {
            //we have a list of file names in an NSData object
            NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
            
            NSUInteger mcount =[fileArray count];
            
            //NSLog (@"array = %lu", mcount);
            
        
            if( mcount >1)
            {
                NSRunAlertPanel(@"File Reading Error", 
                                [NSString stringWithFormat:@"Please drop one file at a time"], nil, nil, nil);  
                return NO;

            }
            
            
            //be caseful since this method returns id.  
            //We just happen to know that it will be an array.
            NSString *subjectFilePath = [fileArray objectAtIndex:0];
            
            //NSUInteger *pathLen = [subjectFilePath length] - [4 inValue];
            
            NSString *subjectDirectoy = [subjectFilePath substringWithRange:NSMakeRange(0, [subjectFilePath length]-4)];
           //substringToIndex
             //           int filelen = ;
            //assume that we can ignore all but the first path in the list
           
            NSLog(@"File to expand: \"%@\"", subjectFilePath);
           
            NSString *phpCodePath = [[NSBundle mainBundle] bundlePath];
            NSString *escapedPath = [phpCodePath stringByReplacingOccurrencesOfString:@" " withString:@"\\ "];

            phpCodePath = [NSString stringWithFormat:@"%@/expandt3x/", phpCodePath];
            NSString *phpCodeExec = [NSString stringWithFormat:@"/usr/bin/php -c %@ %@expandt3x.php %@ %@", 
                                     phpCodePath, phpCodePath, subjectFilePath, subjectDirectoy];
            
            NSLog(@"escapedPath \"%@\"", escapedPath);            
            NSLog(@"phpCodeExec \"%@\"", phpCodeExec);
            
            //set phpcommand to "/usr/bin/php -c" & hiddeninipath & " " & hiddenscriptpath & " " & full_path & " " & full_path_new
            
        }
        else
        {
            //this can't happen
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    
    [self setNeedsDisplay:YES];    //redraw us with the new image
    return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
    //re-draw the view with our new data
    [self setNeedsDisplay:YES];
}



@end
