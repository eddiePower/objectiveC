

#import "RegionsViewController.h"
#import "RegionAnnotationView.h"
#import "RegionAnnotation.h"

@implementation RegionsViewController

@synthesize regionsMapView, updatesTableView, updateEvents, locationManager, navigationBar;

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc
{
	[updateEvents release];
	self.locationManager.delegate = nil;
	[locationManager release];
	[regionsMapView release];
	[updatesTableView release];
	[navigationBar release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Create empty array to add region events to (didEnter, didLeave).
	updateEvents = [[NSMutableArray alloc] initWithCapacity: 0];
	
	//!!Create location manager with filters set for battery efficiency.
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	//Start updating location changes.
	[locationManager startUpdatingLocation];
}


- (void)viewDidAppear:(BOOL)animated
{
	// Get all regions being monitored for this application.
    //NOTE: Will need to Check for Active Alarms
	NSArray *regions = [[locationManager monitoredRegions] allObjects];
	
	// Iterate through the regions/AlarmStops
    //Possibly only one annotation needed
	for (int i = 0; i < [regions count]; i++)
    {
		CLRegion *region = [regions objectAtIndex:i];
		RegionAnnotation *annotation = [[RegionAnnotation alloc] initWithCLRegion:region];
		[regionsMapView addAnnotation:annotation];
		[annotation release];
	}
}


- (void)viewDidUnload
{
	self.updateEvents = nil;
	self.locationManager.delegate = nil;
	self.locationManager = nil;
	self.regionsMapView = nil;
	self.updatesTableView = nil;
	self.navigationBar = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UITableViewDelegate    //Table View Code from here

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [updateEvents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
	cell.textLabel.font = [UIFont systemFontOfSize:12.0];
	cell.textLabel.text = [updateEvents objectAtIndex:indexPath.row];
	cell.textLabel.numberOfLines = 4;
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60.0;
}

//END TABLE VIEW CODE.

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if([annotation isKindOfClass:[RegionAnnotation class]])
    {
		RegionAnnotation *currentAnnotation = (RegionAnnotation *)annotation;
		NSString *annotationIdentifier = [currentAnnotation title];
		RegionAnnotationView *regionView = (RegionAnnotationView *)[regionsMapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];	
		
		if (!regionView)
        {
			regionView = [[[RegionAnnotationView alloc] initWithAnnotation:annotation] autorelease];
			regionView.map = regionsMapView;
			
			// Create a button for the left callout accessory view of each annotation to remove the annotation and region being monitored.
			UIButton *removeRegionButton = [UIButton buttonWithType:UIButtonTypeCustom];
			[removeRegionButton setFrame:CGRectMake(0., 0., 25., 25.)];
			[removeRegionButton setImage:[UIImage imageNamed:@"RemoveRegion"] forState:UIControlStateNormal];
			
			regionView.leftCalloutAccessoryView = removeRegionButton;
		}
        else
        {
			regionView.annotation = annotation;
			regionView.theAnnotation = annotation;
		}
		
		// Update or add the overlay displaying the radius of the region around the annotation.
		[regionView updateRadiusOverlay];
		
		return regionView;		
	}	
	
	return nil;	
}

//Add Radius for region alert, will be updated by UISlider.
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	if([overlay isKindOfClass:[MKCircle class]])
    {
		// Create the view for the radius overlay.
		MKCircleView *circleView = [[[MKCircleView alloc] initWithOverlay:overlay] autorelease];
		circleView.strokeColor = [UIColor purpleColor];
		circleView.fillColor = [[UIColor purpleColor] colorWithAlphaComponent:0.4];
		
		return circleView;		
	}
	
	return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
	if([annotationView isKindOfClass:[RegionAnnotationView class]])
    {
		RegionAnnotationView *regionView = (RegionAnnotationView *)annotationView;
		RegionAnnotation *regionAnnotation = (RegionAnnotation *)regionView.annotation;
		
		// If the annotation view is starting to be dragged, remove the overlay and stop monitoring the region.
		if (newState == MKAnnotationViewDragStateStarting)
        {
			[regionView removeRadiusOverlay];
			
			[locationManager stopMonitoringForRegion:regionAnnotation.region];
		}
		
		// Once the annotation view has been dragged and placed in a new location, update and add the overlay and begin monitoring the new region.
		if (oldState == MKAnnotationViewDragStateDragging && newState == MKAnnotationViewDragStateEnding)
        {
			[regionView updateRadiusOverlay];
			
			CLRegion *newRegion = [[CLRegion alloc] initCircularRegionWithCenter:regionAnnotation.coordinate radius:1000.0 identifier:[NSString stringWithFormat:@"%f, %f", regionAnnotation.coordinate.latitude, regionAnnotation.coordinate.longitude]];
             
			regionAnnotation.region = newRegion;
			[newRegion release];
			
			[locationManager startMonitoringForRegion:regionAnnotation.region desiredAccuracy:kCLLocationAccuracyBest];
		}		
	}	
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	RegionAnnotationView *regionView = (RegionAnnotationView *)view;
	RegionAnnotation *regionAnnotation = (RegionAnnotation *)regionView.annotation;
	
	// Stop monitoring the region, remove the radius overlay, and finally remove the annotation from the map.
	[locationManager stopMonitoringForRegion:regionAnnotation.region];
	[regionView removeRadiusOverlay];
	[regionsMapView removeAnnotation: regionAnnotation];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError: %@", error.userInfo);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
	
	// Work around a bug in MapKit where user location is not initially zoomed to.
	if (oldLocation == nil)
    {
		// Zoom to the current user location.
		MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1500.0, 1500.0);
		[regionsMapView setRegion: userLocation animated: YES];
	}
}

//This method will be the one to alert users to station arival!
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	NSString *event = [NSString stringWithFormat:@"You've Entered the Region %@ at %@", region.identifier, [NSDate date]];
	
	[self updateWithEvent:event];
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
	NSString *event = [NSString stringWithFormat:@"You Exited the Region %@ at %@", region.identifier, [NSDate date]];
	
	[self updateWithEvent:event];
}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
	NSString *event = [NSString stringWithFormat:@"monitoringDidFailForRegion %@: %@", region.identifier, error];
	
	[self updateWithEvent:event];
}


#pragma mark - RegionsViewController

/*
 This method swaps the visibility of the map view and the table of region events.
 The "add region" button in the navigation bar is also altered to only be enabled when the map is shown.
 */
- (IBAction)switchViews
{
	// Swap the hidden status of the map and table view so that the appropriate one is now showing.
	self.regionsMapView.hidden = !self.regionsMapView.hidden;
	self.updatesTableView.hidden = !self.updatesTableView.hidden;
	
	// Adjust the "add region" button to only be enabled when the map is shown.
	NSArray *navigationBarItems = [NSArray arrayWithArray:self.navigationBar.items];
	UIBarButtonItem *addRegionButton = [[navigationBarItems objectAtIndex:0] rightBarButtonItem];
	addRegionButton.enabled = !addRegionButton.enabled;
	
	// Reload the table data and update the icon badge number when the table view is shown.
	if (!updatesTableView.hidden)
    {
		[updatesTableView reloadData];
	}
}

/*
 This method creates a new region based on the center coordinate of the map view.
 A new annotation is created to represent the region and then the application starts monitoring the new region.
 
 !!!WIll need to be transformed to work on Alarms
 */
- (IBAction)addRegion
{
	if ([CLLocationManager regionMonitoringAvailable])
    {
		// Create a new region based on the center of the map view.
		CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(regionsMapView.centerCoordinate.latitude, regionsMapView.centerCoordinate.longitude);
		CLRegion *newRegion = [[CLRegion alloc] initCircularRegionWithCenter:coord 
																	  radius:40.0
																  identifier:[NSString stringWithFormat:@"%f, %f", regionsMapView.centerCoordinate.latitude, regionsMapView.centerCoordinate.longitude]];
		
		// Create an annotation to show where the region is located on the map.
		RegionAnnotation *myRegionAnnotation = [[RegionAnnotation alloc] initWithCLRegion:newRegion];
        
		myRegionAnnotation.coordinate = newRegion.center;
		myRegionAnnotation.radius = newRegion.radius;
		
		[regionsMapView addAnnotation: myRegionAnnotation];
		
		[myRegionAnnotation release];
		
		
        
        
        // Start monitoring the newly created region.
		[locationManager startMonitoringForRegion:newRegion desiredAccuracy:kCLLocationAccuracyBest];
		
        
        
        
		[newRegion release];
	}
	else
    {
		NSLog(@"Region monitoring is not available.");
	}
}


/*
 This method adds the region event to the events array and updates the icon badge number.
 */
- (void)updateWithEvent:(NSString *)event
{
	// Add region event to the updates array.
	[updateEvents insertObject: event atIndex: 0];
	
	// Update the icon badge number.
	[UIApplication sharedApplication].applicationIconBadgeNumber++;
	
	if (!updatesTableView.hidden)
    {
		[updatesTableView reloadData];
	}
}


@end
