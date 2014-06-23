

#import "TeslameterViewController.h"

@interface GraphView : UIView {
	NSUInteger nextIndex;
	CLHeadingComponentValue history[150][3];
}

- (void)updateHistoryWithX:(CLHeadingComponentValue)x y:(CLHeadingComponentValue)y z:(CLHeadingComponentValue)z;

@end

