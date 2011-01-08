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
	scrollView.maximumZoomScale = 2.0;
	scrollView.minimumZoomScale = 1.0;
	//scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	[scrollView addSubview:imageView];
	
	// Initial zentrieren
	[self scrollViewDidZoom:scrollView];
}

- (void) resetScrollView{
	// Alle vorherigen Subviews loeschen
	for (UIView *view in [scrollView subviews]) {
		[view removeFromSuperview];
	}
	
	//Bounds zuruecksetzen
	scrollView.bounds = scrollView.frame;
}

// Zentriert das Image im ScrollView
-(void)scrollViewDidZoom:(UIScrollView *)pScrollView {
	CGRect innerFrame = imageView.frame;
	CGRect scrollerBounds = pScrollView.bounds;
	
	if ( ( innerFrame.size.width < scrollerBounds.size.width ) || ( innerFrame.size.height < scrollerBounds.size.height ) )
	{
		CGFloat tempx = imageView.center.x - ( scrollerBounds.size.width / 2 );
		CGFloat tempy = imageView.center.y - ( scrollerBounds.size.height / 2 );
		CGPoint myScrollViewOffset = CGPointMake( tempx, tempy);
		
		pScrollView.contentOffset = myScrollViewOffset;
		
	}
	
	UIEdgeInsets anEdgeInset = { 0, 0, 0, 0};
	if ( scrollerBounds.size.width > innerFrame.size.width )
	{
		anEdgeInset.left = (scrollerBounds.size.width - innerFrame.size.width) / 2;
		anEdgeInset.right = -anEdgeInset.left;  // I don't know why this needs to be negative, but that's what works
	}
	if ( scrollerBounds.size.height > innerFrame.size.height )
	{
		anEdgeInset.top = (scrollerBounds.size.height - innerFrame.size.height) / 2;
		anEdgeInset.bottom = -anEdgeInset.top;  // I don't know why this needs to be negative, but that's what works
	}
	pScrollView.contentInset = anEdgeInset;
}



- (void) showSpotImage{	
	[self resetScrollView];
	
	// ImageView mit einem Bild erstellen
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:spotImage.image];
	[self setImageView: tempImageView];
	[tempImageView release];
	
	// Seitenverhaeltnis des Bildes ermitteln
	double aspectRatio = spotImage.image.size.width / spotImage.image.size.height;
	
	// Variablen fuer die spaetere Zuweisung des imageView Frames
	int width = 0;
	int height = 0;
	
	// Je nachdem welche Seite des Bild die groessere ist, wird das 
	// ImageView an die ScrollView perfekt angepasst
	if (aspectRatio >1 ) {
		// Breite > Hoehe
		width = scrollView.bounds.size.width;
		height = width / aspectRatio;
	}
	else{
		// Hoehe > Breite
		height = scrollView.bounds.size.height;
		width = height * aspectRatio;
	}
	
	
	imageView.frame = CGRectMake(0,0, width, height);
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.userInteractionEnabled = true;
	imageView.clipsToBounds = true;
		
	UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]; 
	[imageView addGestureRecognizer:longPressGesture];
	
	[self updateScrollView];
}

- (void) longPress:(UILongPressGestureRecognizer*)gesture{
	
	if (gesture.state == UIGestureRecognizerStateBegan) {
		// Relative Position des Clicks zum ImageView ermitteln
		int x = [gesture locationInView:imageView].x;
		int y = [gesture locationInView:imageView].y;
		
		// Verhaeltnis der Groesse des Originalbildes zum ImageView ermitteln
		float aspectWidth = spotImage.image.size.width / imageView.frame.size.width;
		float aspectHeight = spotImage.image.size.height / imageView.frame.size.height; 
				
		NSLog(@"%f %f", aspectWidth * x, aspectHeight * y);
	}
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
