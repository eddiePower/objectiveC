
#import "ReverseViewController.h"
#import "PlacemarksListViewController.h"

#define kSanFranciscoCoordinate CLLocationCoordinate2DMake(37.776278, -122.419367)

@interface ReverseViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (readonly) CLLocationCoordinate2D currentUserCoordinate;
@property (readonly) NSInteger selectedRow;

@property (weak, readonly) UIActivityIndicatorView *spinner;
@property (weak, readonly) UIActivityIndicatorView *currentLocationActivityIndicatorView;

@end


#pragma mark -

@implementation ReverseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // start with San Francisco
    _currentUserCoordinate = kCLLocationCoordinate2DInvalid;
    _selectedRow = 0;
}

// viewDidUnload is not called on iOS 6.0 and later
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (void)viewDidUnload
{
    // if the view has gone away, so should we set our weak pointer
    _spinner = nil;
    _currentLocationActivityIndicatorView = nil;
    
    [super viewDidUnload];
}
#endif


#pragma mark - View Controller Rotation

// rotation support for iOS 5.x and earlier, note for iOS 6.0 and later all you need is
// "UISupportedInterfaceOrientations" defined in your Info.plist
//
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else
    {
        return YES;
    }
}
#endif


#pragma mark - UI Handling

- (void)showSpinner:(UIActivityIndicatorView *)whichSpinner withShowState:(BOOL)show
{
    whichSpinner.hidden = (show) ? NO : YES;
    if (show)
    {
        [whichSpinner startAnimating];
    }
    else
    {
        [whichSpinner stopAnimating];
    }
}

- (void)showCurrentLocationSpinner:(BOOL)show
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    assert(cell);
    
    if (!_currentLocationActivityIndicatorView)
    {
        // add the spinner to the table cell
        UIActivityIndicatorView *curLocSpinner =
            [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [curLocSpinner startAnimating];    
        [curLocSpinner setFrame:CGRectMake(200.0, 0.0, 22.0, 22.0)];
        [curLocSpinner setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
        
        _currentLocationActivityIndicatorView = curLocSpinner; // keep a weak ref around for later
        cell.accessoryView = _currentLocationActivityIndicatorView;
    }
    
    if (!show && _selectedRow == 1)
    {
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)showSpinner:(BOOL)show
{
    if (!_spinner)
    {
        // add the spinner to the table's footer view
        UIView *containerView = [[UIView alloc] initWithFrame:
                                    CGRectMake(0.0, 0.0, CGRectGetWidth(self.tableView.frame), 22.0)];
        UIActivityIndicatorView *spinner =
            [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
           
        // size and center the spinner
        [spinner setFrame:CGRectZero];
        [spinner sizeToFit];
        CGRect frame = spinner.frame;
        frame.origin.x = (CGRectGetWidth(self.tableView.frame) - CGRectGetWidth(frame)) / 2.0;
        spinner.frame = frame;
        [spinner startAnimating]; 
        
        [containerView addSubview:spinner];
        self.tableView.tableFooterView = containerView;
        _spinner = spinner; // keep a weak ref around for later
    }
    
    [self showSpinner:self.spinner withShowState:show];
}

- (void)lockUI:(BOOL)lock
{
    // prevent user interaction while we are processing the forward geocoding
    self.tableView.allowsSelection = !lock;
    [self showSpinner:lock];
}


#pragma mark - Display Results

// display the results
- (void)displayPlacemarks:(NSArray *)placemarks
{
    dispatch_async(dispatch_get_main_queue(),^ {
        [self lockUI:NO];
        
        PlacemarksListViewController *plvc = [[PlacemarksListViewController alloc] initWithPlacemarks:placemarks preferCoord:YES];
        [self.navigationController pushViewController:plvc animated:YES];
    });
}

// display a given NSError in an UIAlertView
- (void)displayError:(NSError*)error
{
    dispatch_async(dispatch_get_main_queue(),^ {
        [self lockUI:NO];

        NSString *message;
        switch ([error code])
        {
            case kCLErrorGeocodeFoundNoResult: message = @"kCLErrorGeocodeFoundNoResult";
                break;
            case kCLErrorGeocodeCanceled: message = @"kCLErrorGeocodeCanceled";
                break;
            case kCLErrorGeocodeFoundPartialResult: message = @"kCLErrorGeocodeFoundNoResult";
                break;
            default: message = [error description];
                break;
        }

        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"An error occurred."
                                                    message:message
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];;
        [alert show];
    });   
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of rows in the section
    if (section == 0)
        return 2;
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Choose a location:";
    else
        return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    if (!cell)
    {
        UITableViewCellStyle style = (indexPath.section == 0) ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault; 
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"basicCell"];
    }
       
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {    
                cell.textLabel.text = @"San Francisco";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"φ:%.4F, λ:%.4F", kSanFranciscoCoordinate.latitude, kSanFranciscoCoordinate.longitude];
                break;
            }
                
            case 1:
            {
                cell.textLabel.text = @"Current Location";
                if (CLLocationCoordinate2DIsValid(_currentUserCoordinate))
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"φ:%.4F, λ:%.4F", _currentUserCoordinate.latitude, _currentUserCoordinate.longitude];
                else
                {
                    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || 
                        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted )
                    {
                        cell.detailTextLabel.text = @"Location Services Disabled";
                    }
                    else
                    {
                        cell.detailTextLabel.text = @"<unknown>"; 
                    }
                }
                break;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITableViewCellAccessoryType accessoryType =
            (_selectedRow == indexPath.row) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        cell.accessoryType = accessoryType;
    }
    else
    {
        cell.textLabel.text = @"Geocode Coordinate";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        // perform the Geocode
        [self performCoordinateGeocode:self];
    }
    else
    {
        NSInteger whichCellRow = (indexPath.row == 0) ? 1 : 0;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:whichCellRow inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (indexPath.row == 1)
        {
            [self startUpdatingCurrentLocation];
        }
        
        _selectedRow = indexPath.row;
    }
}


#pragma mark - CLLocationManagerDelegate

- (void)startUpdatingCurrentLocation
{
    // if location services are restricted do nothing
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || 
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted )
    {
        return;
    }
    
    // if locationManager does not currently exist, create it
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        _locationManager.distanceFilter = 10.0f; // we don't need to be any more accurate than 10m
        _locationManager.purpose = @"This may be used to obtain your reverse geocoded address";
    }
    
    [_locationManager startUpdatingLocation];
    
    [self showCurrentLocationSpinner:YES];
}

- (void)stopUpdatingCurrentLocation
{
    [_locationManager stopUpdatingLocation];
    
    [self showCurrentLocationSpinner:NO];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{		
    // if the location is older than 30s ignore
    if (fabs([newLocation.timestamp timeIntervalSinceDate:[NSDate date]]) > 30)
    {
        return;
    }
    
    _currentUserCoordinate = [newLocation coordinate];
    _selectedRow = 1;
    
    // update the current location cells detail label with these coords
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Long:%.4F, Latt:%.4F", _currentUserCoordinate.latitude, _currentUserCoordinate.longitude];

    // after recieving a location, stop updating
    [self stopUpdatingCurrentLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.userInfo);
    
    // stop updating
    [self stopUpdatingCurrentLocation];
    
    // since we got an error, set selected location to invalid location
    _currentUserCoordinate = kCLLocationCoordinate2DInvalid;

    // show the error alert
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Error updating location";
    alert.message = [error localizedDescription];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}


#pragma mark - Actions

- (IBAction)performCoordinateGeocode:(id)sender
{
    [self lockUI:YES];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocationCoordinate2D coord = (_selectedRow == 0) ? kSanFranciscoCoordinate : _currentUserCoordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            [self displayError:error];
            return;
        }
        NSLog(@"Received placemarks: %@", placemarks);
        [self displayPlacemarks:placemarks];
    }];
}

@end
