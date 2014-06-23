
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@class GraphView;

@interface TeslameterViewController : UIViewController <CLLocationManagerDelegate> {
	UILabel *magnitudeLabel;
	UILabel *xLabel;
	UILabel *yLabel;
	UILabel *zLabel;
	GraphView *graphView;

	CLLocationManager *locationManager;
}

// IBOutlets
@property (nonatomic, retain) IBOutlet UILabel *magnitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *xLabel;
@property (nonatomic, retain) IBOutlet UILabel *yLabel;
@property (nonatomic, retain) IBOutlet UILabel *zLabel;
@property (nonatomic, retain) IBOutlet GraphView *graphView;

@property (nonatomic, retain) CLLocationManager *locationManager;

@end

