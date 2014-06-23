
#import <UIKit/UIKit.h>

@class TeslameterViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	TeslameterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TeslameterViewController *viewController;

@end
