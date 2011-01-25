#import <UIKit/UIKit.h>

@protocol CustomCalloutDelegate

- (void) calloutButtonClick:(id)param;

@end


@interface CustomCallout : UIControl {
	UIImageView* leftView;
	UIImageView* rightView;
	UIImageView* middleView;
	UIImageView* filler1View;
	UIImageView* filler2View;
	UIButton* button;
	UILabel* label;
	CGPoint _anchor;
	id<CustomCalloutDelegate> delegate;
	id param;
}

- (id)initWithAnchor:(CGPoint)p text:(NSString*)text delegate:(id<CustomCalloutDelegate>)_delegate param:(id)_param;
- (void) showWithAnimationInParent:(UIView*)parent;
- (void) setTitle:(NSString*)_t;
- (void) setDelegate:(id<CustomCalloutDelegate>)_delegate param:(id)_param;
- (void) setAnchor:(CGPoint)p;

@end


