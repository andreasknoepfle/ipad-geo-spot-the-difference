//
//  FirstViewController.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize mapView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[mapView setMapType:MKMapTypeSatellite];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	[mapView setDelegate:self];
	
	

	
	SpotImage *ann=[[SpotImage alloc]initWithLongitude:9.181180000305176 andLatitude:47.67073396981077 
							andTitle: @"Konstanze" andSubtitle:@"Nice Work" andImageName:@"0001.jpg"];
	
	SpotImage *ann2=[[SpotImage alloc]initWithLongitude:9.181180000305176 andLatitude:47.66073396981077 
											  andTitle: @"Konstanze2" andSubtitle:@"Nice Work2" andImageName:@"0002.jpg"];
	
	[mapView addAnnotation:ann];
	[mapView addAnnotation:ann2];
	
	//Start Point
	
	
	
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
