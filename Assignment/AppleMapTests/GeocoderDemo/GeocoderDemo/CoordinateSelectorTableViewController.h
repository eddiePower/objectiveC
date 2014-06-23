
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef enum
{
    CoordinateSelectorLastSelectedTypeSearch = 1,
    CoordinateSelectorLastSelectedTypeCurrent,
    CoordinateSelectorLastSelectedTypeUndefined,
} CoordinateSelectorLastSelectedType;

// this class contains a list of names and associated Coordinates as well as allowing
// for the selection of a custom Coordinate it vends the users selection through
// the 4 selected properties.. 
//
@interface CoordinateSelectorTableViewController : UITableViewController <UITextFieldDelegate, CLLocationManagerDelegate>

@property (readonly) CLLocationCoordinate2D selectedCoordinate;
@property (readonly) CoordinateSelectorLastSelectedType selectedType;
@property (readonly) NSString *selectedName;

@end
