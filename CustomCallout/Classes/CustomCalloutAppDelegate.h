#import <UIKit/UIKit.h>

@class CustomCalloutViewController;

@interface CustomCalloutAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CustomCalloutViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CustomCalloutViewController *viewController;

@end

