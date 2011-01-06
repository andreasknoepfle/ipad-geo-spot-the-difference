//
//  SecondViewController.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotImage.h"
#import "UITouchImageView.h"


@interface ImageViewController : UIViewController <UIScrollViewDelegate> {
	UITouchImageView *imageView;
	UIScrollView *scrollView;
	SpotImage *spotImage;
}

@property (nonatomic, retain) UITouchImageView *imageView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) SpotImage* spotImage;

- (void) updateScrollView;
- (void) showSpotImage;
- (void) resetScrollView;

@end
