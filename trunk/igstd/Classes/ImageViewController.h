//
//  SecondViewController.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageViewController : UIViewController <UIScrollViewDelegate> {
	UIImageView *imageView;
	UIScrollView *scrollView;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (void) setImage: (NSString*) fileName;
- (void) updateScrollView;

@end
