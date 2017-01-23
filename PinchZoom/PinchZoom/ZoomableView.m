//
//  ZoomableView.m
//  PinchZoom
//
//  Created by MacMini on 20/01/17.
//  Copyright © 2017 MacMini. All rights reserved.
//

#import "ZoomableView.h"
#import <QuartzCore/QuartzCore.h>


@implementation ZoomableView
// Set the UIView layer to CATiledLayer
+(Class)layerClass
{
    return [CATiledLayer class];
}


// Initialize the layer by setting
// the levelsOfDetailBias of bias and levelsOfDetail
// of the tiled layer
-(id)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    if(self) {
        CATiledLayer *tempTiledLayer = (CATiledLayer*)self.layer;
        tempTiledLayer.levelsOfDetail = 5;
        tempTiledLayer.levelsOfDetailBias = 2;
        self.opaque=YES;
    }
    return self;
}

// Implement -drawRect: so that the UIView class works correctly
// Real drawing work is done in -drawLayer:inContext
-(void)drawRect:(CGRect)r
{
}

-(void)drawLayer:(CALayer*)layer inContext:(CGContextRef)context
{
    // The context is appropriately scaled and translated such that you can draw to this context
    // as if you were drawing to the entire layer and the correct content will be rendered.
    // We assume the current CTM will be a non-rotated uniformly scaled
    
    // affine transform, which implies that
    // a == d and b == c == 0
    // CGFloat scale = CGContextGetCTM(context).a;
    // While not used here, it may be useful in other situations.
    
    // The clip bounding box indicates the area of the context that
    // is being requested for rendering. While not used here
    // your app may require it to do scaling in other
    // situations.
    // CGRect rect = CGContextGetClipBoundingBox(context);
    
    // Set and draw the background color of the entire layer
    // The other option is to set the layer as opaque=NO;
    // eliminate the following two lines of code
    // and set the scroll view background color
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,self.bounds);
    
    // draw a simple plus sign
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context,35,255);
    CGContextAddLineToPoint(context,35,205);
    CGContextAddLineToPoint(context,135,205);
    CGContextAddLineToPoint(context,135,105);
    CGContextAddLineToPoint(context,185,105);
    CGContextAddLineToPoint(context,185,205);
    CGContextAddLineToPoint(context,285,205);
    CGContextAddLineToPoint(context,285,255);
    CGContextAddLineToPoint(context,185,255);
    CGContextAddLineToPoint(context,185,355);
    CGContextAddLineToPoint(context,135,355);
    CGContextAddLineToPoint(context,135,255);
    CGContextAddLineToPoint(context,35,255);
    CGContextClosePath(context);
    
    // Stroke the simple shape
    CGContextStrokePath(context);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
