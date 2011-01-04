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
	
	
		
	
	MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
	region.center.latitude = 47.67073396981077;
	region.center.longitude = 9.181180000305176;
	DisplayMap *ann=[[DisplayMap alloc]init];
	ann.title = @" Test";
	ann.subtitle = @"Mahatma Gandhi Road"; 
	ann.coordinate = region.center; 
	[mapView addAnnotation:ann];
	
	MKCoordinateRegion region2 = {{0.0,0.0},{0.0,0.0}};
	region2.center.latitude = 47.66073396981077;
	region2.center.longitude = 9.181180000305176;
	ann=[[DisplayMap alloc]init];
	ann.title = @" Kolkata";
	ann.subtitle = @"Mahatma Gandhi Road"; 
	ann.coordinate = region2.center; 
	[mapView addAnnotation:ann];
	
	//Start Point
	
	
	
}


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil] autorelease];
		pinView.canShowCallout = YES;
		
		pinView.pinColor = MKPinAnnotationColorRed;
		//pinView.animatesDrop = YES;
		UIImageView * leftIconView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed: @"0001.jpg"] getThumbnailWithSize:32]];
		pinView.leftCalloutAccessoryView = leftIconView;
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
