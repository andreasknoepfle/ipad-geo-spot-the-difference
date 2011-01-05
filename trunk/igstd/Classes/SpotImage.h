//
//  DisplayMap.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface SpotImage : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate; 
	NSString * title; 
	NSString * subtitle;
	UIImage *image;
	double latitude;
	double longitude;
	
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@end