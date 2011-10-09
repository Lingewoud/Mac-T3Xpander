//
//  DropZone.h
//  T3x Expander
//
//  Created by Pim Snel on 06-10-11.
//  Copyright 2011 Lingewoud B.V. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TEUnpackT3x.h"

//NSView *dropZoneImage;

@interface TEDropZone : NSImageView

//@property (assign) IBOutlet NSView *dropZoneImage;

- (void)dropAreaFadeIn;
- (void)dropAreaFadeOut;

@end


