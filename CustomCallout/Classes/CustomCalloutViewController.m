#import "CustomCalloutViewController.h"
@implementation CustomCalloutViewController

- (void) calloutButtonClick:(id)param {
	UIAlertView * av = [[[UIAlertView alloc] initWithTitle:@"Click!" 
												   message:[param currentTitle]
												  delegate:nil 
										 cancelButtonTitle:@"Ok" 
										 otherButtonTitles:nil]autorelease];
	[av show];
}


- (IBAction) buttonClicked:(id)sender {
	for(id uv in self.view.subviews){
		if([uv class] == [CustomCallout class]){
			[uv removeFromSuperview];
		}
	}
	CGPoint p = [sender frame].origin;
	p.x += [sender frame].size.width/2;
	p.y += [sender frame].size.height/2;
	CustomCallout* cc = [[CustomCallout alloc] initWithAnchor:p text:@"Test Callout!" delegate:self param:sender];
	[cc showWithAnimationInParent:self.view];
	[cc release];
}


- (void)dealloc {
    [super dealloc];
}

@end
