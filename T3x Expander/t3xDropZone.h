//
//  t3xDropZone.h
//  T3x Expander
//
//  Created by Pim Snel on 12-04-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface t3xDropZone : NSView {

    NSImage *_ourImage;


@private
    
}

- (void)setImage:(NSImage *)newImage;

- (NSImage *)image;

@end
