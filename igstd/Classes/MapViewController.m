//
//  FirstViewController.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "DisplayMap.h"

@implementation MapViewController

@synthesize mapView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[mapView setMapType:MKMapTypeSatellite];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
	region.center.latitude = 47.66073396981077;
	region.center.longitude = 9.181180000305176;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES];
	[mapView setDelegate:self];
	
	DisplayMap *ann=[[DisplayMap alloc]init];
	
	ann.title = @" Kolkata";
	ann.subtitle = @"Mahatma Gandhi Road"; 
	ann.coordinate = region.center; 
	[mapView addAnnotation:ann];
}


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
	} 
	else {
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
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
