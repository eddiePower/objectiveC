
#import <UIKit/UIKit.h>

@interface PlacemarksListViewController : UITableViewController

// designated initilizers
- (id)initWithPlacemarks:(NSArray*)placemarks preferCoord:(BOOL)shouldPreferCoord; // show the coord in the main textField in the cell if YES
- (id)initWithPlacemarks:(NSArray*)placemarks;

@end
