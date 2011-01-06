//
//  SecondViewController.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageManager.h"


@implementation ImageViewController

@synthesize scrollView, imageView, spotImage;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}	

- (void) updateScrollView{	
	scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.1;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	[scrollView addSubview:imageView];
}

- (void) resetScrollView{
	// Alle vorherigen Subviews loeschen
	for (UIView *view in [scrollView subviews]) {
		[view removeFromSuperview];
	}
}


- (void) showSpotImage{	
	// ImageView mit einem Bild erstellen
	UIImageView	*tempImageView = [[UIImageView alloc] initWithImage:spotImage.image];
	[self setImageView: tempImageView];
	[tempImageView release];
	
	// Initial das ImageView auf die Groesse des ScrollView setzen,
	// damit das Bild komplett angezeigt wird
	imageView.frame = scrollView.bounds; //CGRectMake(0,0, scrollView.contentSize.width, scrollView.contentSize.height);
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	
	[self updateScrollView];
}
							  

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
	// Falls das imageView kleiner wird als das Scrollview so wird es
	// auf die ideale groesse vergroessert
	//TODO
	
	// imageView zurueckgeben, damit das Scrollview sein content darauf anpasst
	return imageView;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[scrollView release];
	[imageView release];
    [super dealloc];
}

@end
