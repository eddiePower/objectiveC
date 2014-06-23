
#import "TeslameterViewController.h"
#import "GraphView.h"

@implementation TeslameterViewController

@synthesize magnitudeLabel;
@synthesize xLabel;
@synthesize yLabel;
@synthesize zLabel;
@synthesize graphView;

@synthesize locationManager;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// setup the location manager
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	
	// check if the hardware has a compass
	if ([CLLocationManager headingAvailable] == NO) {
		// No compass is available. This application cannot function without a compass, 
        // so a dialog will be displayed and no magnetic data will be measured.
        self.locationManager = nil;
        UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!" message:@"This device does not have the ability to measure magnetic fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noCompassAlert show];
        [noCompassAlert release];
	} else {
        // heading service configuration
        locationManager.headingFilter = kCLHeadingFilterNone;
        
        // setup delegate callbacks
        locationManager.delegate = self;
        
        // start the compass
        [locationManager startUpdatingHeading];
    }
}

- (void)viewDidUnload {
    self.magnitudeLabel = nil;
    self.xLabel = nil;
    self.yLabel = nil;
    self.zLabel = nil;
    self.graphView = nil;
}

- (void)dealloc {
	[magnitudeLabel release];
	[xLabel release];
	[yLabel release];
	[zLabel release];
	[graphView release];
	
	// Stop the compass
	[locationManager stopUpdatingHeading];
    [locationManager release];
	[super dealloc];
}

// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    // Update the labels with the raw x, y, and z values.
	[xLabel setText:[NSString stringWithFormat:@"%.1f", heading.x]];
	[yLabel setText:[NSString stringWithFormat:@"%.1f", heading.y]];
	[zLabel setText:[NSString stringWithFormat:@"%.1f", heading.z]];
    
    // Compute and display the magnitude (size or strength) of the vector.
	//      magnitude = sqrt(x^2 + y^2 + z^2)
	CGFloat magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    [magnitudeLabel setText:[NSString stringWithFormat:@"%.1f", magnitude]];
	
	// Update the graph with the new magnetic reading.
	[graphView updateHistoryWithX:heading.x y:heading.y z:heading.z];
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}

@end
