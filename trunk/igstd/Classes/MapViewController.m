//
//  FirstViewController.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "ImageManager.h"


@implementation MapViewController

@synthesize mapView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[mapView setMapType:MKMapTypeSatellite];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	[mapView setDelegate:self];
	
	for(SpotImage* spotImage in [[ImageManager getImageManager] spotImages]){
		[mapView addAnnotation:spotImage];
	}	
}


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		SpotImage * spotimage=(SpotImage * )annotation;
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
		pinView.canShowCallout = YES;
		
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.animatesDrop = YES;
		UIImageView * leftIconView = [[UIImageView alloc] initWithImage:[spotimage.image getThumbnailWithSize:32]];
		pinView.leftCalloutAccessoryView = leftIconView;
		UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		rightButton.tag = (int)spotimage; 
		[rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = rightButton;
	} 
	else {
		[mapView.userLocation setTitle:@"User Position"];
	}
	return pinView;
}

- (IBAction) annotationViewClick:(id) sender {
	
	SpotImage * spotimage = (SpotImage*)((UIControl*)sender).tag;
	NSLog(@"Clicked");
	
	NSLog(spotimage.title);
	
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
    [super dealloc];
}

@end
