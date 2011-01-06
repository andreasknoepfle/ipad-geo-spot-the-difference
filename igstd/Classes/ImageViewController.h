//
//  SecondViewController.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotImage.h"


@interface ImageViewController : UIViewController <UIScrollViewDelegate> {
	UIImageView *imageView;
	UIScrollView *scrollView;
	SpotImage *spotImage;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) SpotImage* spotImage;

- (void) updateScrollView;
- (void) showSpotImage;

@end
