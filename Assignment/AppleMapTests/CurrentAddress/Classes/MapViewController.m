
#import "MapViewController.h"
#import "PlacemarkViewController.h"

@interface MapViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *getAddressButton;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKPlacemark *placemark;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	   
	// Create a geocoder and save it for later.
    self.geocoder = [[CLGeocoder alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"pushToDetail"])
    {
		// Get the destination view controller and set the placemark data that it should display.
        PlacemarkViewController *viewController = segue.destinationViewController;
        viewController.placemark = self.placemark;
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	// Center the map the first time we get a real location change.
	static dispatch_once_t centerMapFirstTime;

	if ((userLocation.coordinate.latitude != 0.0) && (userLocation.coordinate.longitude != 0.0))
    {
		dispatch_once(&centerMapFirstTime, ^{
			[self.mapView setCenterCoordinate: userLocation.coordinate animated:YES];
		});
	}
    
	// Lookup the information for the current location of the user.
    [self.geocoder reverseGeocodeLocation: self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
		if ((placemarks != nil) && (placemarks.count > 0))
        {
			// If the placemark is not nil then we have at least one placemark. Typically there will only be one.
			_placemark = [placemarks objectAtIndex:0];
			
            NSLog(@"\nPlacemark: %@", self.placemark.addressDictionary);
            
			// we have received our current location, so enable the "Get Current Address" button
			[self.getAddressButton setEnabled:YES];
            
            //NSLog(@"\nLatitude is now: %f\nLongtitude is now: %f", self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
            
            //Add text to the label eddie added each time the long or latt is updated.
            self.locationLabel.text = [NSString stringWithFormat:@"Lat: %f, Long: %f", self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude];
		}
		else
        {
			// Handle the nil case if necessary.
		}
    }];
}

@end
