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
	UILabel * foundDiffs;
	UILabel * allDiffs;
	NSMutableArray * foundDiffsArray;
	UIImage * backupImage;
	
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage * backupImage;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *foundDiffs;
@property (nonatomic, retain) IBOutlet UILabel *allDiffs;
@property (nonatomic, retain) SpotImage* spotImage;
@property (nonatomic, retain) NSMutableArray * foundDiffsArray;

- (void) updateScrollView;
- (void) showSpotImage;
- (void) resetScrollView;
- (void) longPress:(UILongPressGestureRecognizer*)gesture;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;

@end
