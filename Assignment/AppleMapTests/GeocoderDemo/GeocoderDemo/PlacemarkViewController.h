
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PlacemarkViewController : UITableViewController <MKAnnotation>

// designated initilizers
- (id)initWithPlacemark:(CLPlacemark *)placemark preferCoord:(BOOL)shouldPreferCoord; // show the map and coord. above the address info.
- (id)initWithPlacemark:(CLPlacemark *)placemark;


#pragma mark - MKAnnotation Protocol (for map pin)

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (NSString *)title;

@end
