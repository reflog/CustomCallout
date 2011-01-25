#import "CustomCallout.h"
#import "UIView+position.h"

@implementation CustomCallout

static UIImage* left, *right, *bg, *up, *down;

#define CW 265
#define NIPH 13
#define CH 70
#define COMP_TOP_OFFSET 5
#define COMP_SIDE_OFFSET 15
#define LABEL_HEIGHT 40

- (void) click {
	[delegate calloutButtonClick:param];
}


-(void) showWithAnimationInParent:(UIView*)parent
{
	self.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1f];
	[parent addSubview:self];
	self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
	[UIView commitAnimations];
}

- (void) setTitle:(NSString*)_t {
	label.text = _t;
	[self setNeedsLayout];
}

- (void) setDelegate:(id<CustomCalloutDelegate>)_delegate param:(id)_param {
	if(_delegate == nil){
		[button removeFromSuperview];
	}else {
		delegate = _delegate;
		param = _param;
		[button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
		if([button superview] == nil){
			[self addSubview:button];
			[self bringSubviewToFront:button];
		}
	}	
	[self setNeedsLayout];
}

- (void) setAnchor:(CGPoint)p {
	_anchor = p;
	middleView.image = ((p.y - CH) < 0) ? up : down;
	[self setNeedsLayout];
}


- (id)initWithAnchor:(CGPoint)p text:(NSString*)text delegate:(id<CustomCalloutDelegate>)_delegate param:(id)_param {
    self = [super initWithFrame:CGRectZero];
    if (self) {
		self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = YES;
        if(left == nil) left = [UIImage imageNamed:@"UICalloutViewLeftCap"];
        if(right == nil) right = [UIImage imageNamed:@"UICalloutViewRightCap"];
        if(down == nil) down = [UIImage imageNamed:@"UICalloutViewBottomAnchor"];
        if(up == nil) up = [UIImage imageNamed:@"UICalloutViewTopAnchor"];
        if(bg == nil) bg = [UIImage imageNamed:@"UICalloutViewBackground"];
		leftView = [[UIImageView alloc] initWithImage:left];
		rightView = [[UIImageView alloc] initWithImage:right];
		middleView = [[UIImageView alloc] initWithImage:up];
		filler1View = [[UIImageView alloc] initWithImage:bg];
		filler2View = [[UIImageView alloc] initWithImage:bg];
		button = [[UIButton buttonWithType:UIButtonTypeDetailDisclosure] retain];
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor whiteColor];
		label.numberOfLines = 2;
		[self addSubview:leftView];
		[self addSubview:rightView];
		[self addSubview:middleView];
		[self addSubview:filler1View];
		[self addSubview:filler2View];
		[self addSubview:label];
		[self setAnchor:p];
		[self setTitle:text];
		[self setDelegate:_delegate param:_param];
    }
    return self;
}

- (void) layoutSubviews {
	CGRect _parentFrame = self.superview.frame;
	BOOL dirUp = (_anchor.y - CH) > 5  ;
	int frameY = dirUp ?  _anchor.y - CH: _anchor.y;
	int frameX = _anchor.x - CW/2;
	frameX = MAX(frameX,5); 
	if(frameX+CW>_parentFrame.size.width) 
		frameX = _parentFrame.size.width - 5 - CW;
	self.frame = CGRectMake(frameX,frameY, CW, CH);
	
	
	int mx = _anchor.x - frameX - middleView.frameWidth/2;
	int my = 0 ;
	

	int cy = dirUp ? 0 : NIPH;
	int SLW = mx - leftView.frameWidth;
	int SRW = CW - leftView.frameWidth - SLW - middleView.frameWidth - rightView.frameWidth;
	
	leftView.frameOrigin = CGPointMake(0,cy);
	
	filler1View.frame = CGRectMake(leftView.frameWidth,cy,SLW,filler1View.frameHeight);
	
	middleView.frameOrigin = CGPointMake(mx,my);
	
	filler2View.frame = CGRectMake(mx+middleView.frameWidth, cy, SRW, filler2View.frameHeight);
	
	rightView.frameOrigin = CGPointMake(CW-rightView.frameWidth,cy);
	
	button.frameOrigin = CGPointMake(CW - button.frameWidth - COMP_SIDE_OFFSET, cy + COMP_TOP_OFFSET);
	
	label.frame = CGRectMake(COMP_SIDE_OFFSET, cy + COMP_TOP_OFFSET, CW - (COMP_SIDE_OFFSET + (button.superview == nil ?  0 : COMP_SIDE_OFFSET+button.frameWidth)), LABEL_HEIGHT);	
}

#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


- (void)dealloc {
	RELEASE_SAFELY(leftView);
	RELEASE_SAFELY(filler1View);
	RELEASE_SAFELY(middleView);
	RELEASE_SAFELY(filler2View);
	RELEASE_SAFELY(rightView);
	RELEASE_SAFELY(button);
	RELEASE_SAFELY(label);
    [super dealloc];
}


@end
