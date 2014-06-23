

#import "GraphView.h"

@implementation GraphView

- (void)updateHistoryWithX:(CLHeadingComponentValue)x y:(CLHeadingComponentValue)y z:(CLHeadingComponentValue)z {

	// Add to history.
	history[nextIndex][0] = x;
	history[nextIndex][1] = y;
	history[nextIndex][2] = z;

	// Advance the index counter.
    nextIndex = (nextIndex + 1) % 150;
    
    // Mark itself as needing to be redrawn.
	[self setNeedsDisplay];
}

- (void)drawGraphInContext:(CGContextRef)context withBounds:(CGRect)bounds {
    CGFloat value, temp;

    // Save any previous graphics state settings before setting the color and line width for the current draw.
    CGContextSaveGState(context);
	CGContextSetLineWidth(context, 1.0);

	// Draw the intermediate lines
	CGContextSetGrayStrokeColor(context, 0.6, 1.0);
	CGContextBeginPath(context);
	for (value = -5 + 1.0; value <= 5 - 1.0; value += 1.0) {
	
		if (value == 0.0) {
			continue;
		}
		temp = 0.5 + roundf(bounds.origin.y + bounds.size.height / 2 + value / (2 * 5) * bounds.size.height);
		CGContextMoveToPoint(context, bounds.origin.x, temp);
		CGContextAddLineToPoint(context, bounds.origin.x + bounds.size.width, temp);
	}
	CGContextStrokePath(context);
	
	// Draw the center line
	CGContextSetGrayStrokeColor(context, 0.25, 1.0);
	CGContextBeginPath(context);
	temp = 0.5 + roundf(bounds.origin.y + bounds.size.height / 2);
	CGContextMoveToPoint(context, bounds.origin.x, temp);
	CGContextAddLineToPoint(context, bounds.origin.x + bounds.size.width, temp);
	CGContextStrokePath(context);

    // Restore previous graphics state.
    CGContextRestoreGState(context);
}

- (void)drawHistory:(NSUInteger)axis fromIndex:(NSUInteger)index inContext:(CGContextRef)context bounds:(CGRect)bounds {
    CGFloat value;
	    
	CGContextBeginPath(context);
    for (NSUInteger counter = 0; counter < 150; ++counter) {
        // UIView referential has the Y axis going down, so we need to draw upside-down.
        value = history[(index + counter) % 150][axis] / -128; 
        if (counter > 0) {
            CGContextAddLineToPoint(context, bounds.origin.x + (float)counter / (float)(150 - 1) * bounds.size.width, bounds.origin.y + bounds.size.height / 2 + value * bounds.size.height / 2);
        } else {
            CGContextMoveToPoint(context, bounds.origin.x + (float)counter / (float)(150 - 1) * bounds.size.width, bounds.origin.y + bounds.size.height / 2 + value * bounds.size.height / 2);
        }
    }
    // Save any previous graphics state settings before setting the color and line width for the current draw.
    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, (axis == 0 ? 1.0 : 0.0), (axis == 1 ? 1.0 : 0.0), (axis == 2 ? 1.0 : 0.0), 1.0);
	CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);
    // Restore previous graphics state.
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)clip {
    NSUInteger index = nextIndex;
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect bounds = CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height);
	
	// create the graph
	[self drawGraphInContext:context withBounds:bounds];
	
    // plot x,y,z with anti-aliasing turned off
    CGContextSetAllowsAntialiasing(context, false);
    for (NSUInteger i = 0; i < 3; ++i) {
		[self drawHistory:i fromIndex:index inContext:context bounds:bounds];
    }
    CGContextSetAllowsAntialiasing(context, true);
}


@end
