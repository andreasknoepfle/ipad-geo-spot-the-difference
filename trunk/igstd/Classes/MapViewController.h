//
//  FirstViewController.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	<MapKit/MapKit.h>
#import "SpotImage.h"
#import "UIImage+Resizing.h"


@interface MapViewController : UIViewController <MKMapViewDelegate>{

	IBOutlet MKMapView * mapView;
	
	
}

@property (nonatomic,retain) IBOutlet MKMapView * mapView;

@end
