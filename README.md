# CustomCallout - a UICalloutView replacement for iOS
This is a custom control that you can use to emulate the look and feel of Apple's UICalloutView, without using any private APIs.

## Features

All the basic functionality, correct placement on the screen, support for **Retina**.

![](https://github.com/reflog/CustomCallout/raw/master/Screenshot.png)


## Requirement

* iOS 3.0 SDK or later, demo project is using iOS 4.1 SDK.
* QuartzCore framework.

## How to Use

1. Copy the images, __CustomCallout.*__ and __UIView+position.h__ to your project
2. Add the control as:
```objc
	CustomCallout* cc = [[CustomCallout alloc] initWithAnchor:p text:@"Test Callout!" delegate:self param:sender];
	[cc showWithAnimationInParent:self.view];
	[cc release];
```
3. Profit! 

## License

CustomControl is released under MIT License.
