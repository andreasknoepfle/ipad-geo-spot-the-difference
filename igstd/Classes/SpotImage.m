//
//  DisplayMap.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpotImage.h"
#import "Foundation/NSDictionary.h"

@implementation SpotImage

@synthesize coordinate,title,subtitle,image;


-(id)initWithLongitude:(double)_longitude andLatitude:(double)_latitude andTitle:(NSString *)_title 
		   andSubtitle:(NSString *)_subtitle andImageName:(NSString *) imageName{
	self = [super init];
	
	if(self != nil) {
		MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
		region.center.latitude = _latitude;
		region.center.longitude = _longitude;
		self.coordinate = region.center ;
		self.title=_title;
		self.subtitle=_subtitle;
		self.image=[UIImage imageNamed:imageName];
	}
	return self;
}

-(id) initWithPlist:(NSString *)path{
	self = [super init];
	
	NSDictionary* data = [NSDictionary dictionaryWithContentsOfFile:path];
	
	// Beschriftung einlesen
	self.title = [data objectForKey:@"Title"];
	self.subtitle = [data objectForKey:@"Description"];

	// Bild einlesen
	NSString* imageName = [data objectForKey:@"ImagePath"];
	self.image = [UIImage imageNamed:imageName];
	
	// Koordinaten einlesen
	NSNumber* latitude = [data objectForKey:@"Latitude"];
	NSNumber* longitude = [data objectForKey:@"Longitude"];
	MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
	region.center.latitude = [latitude doubleValue];
	region.center.longitude = [longitude doubleValue];
	self.coordinate = region.center;
	
	return self;
}



-(void)dealloc{
	[title release];
	[subtitle release];
	[image release];
	[super dealloc];
}
@end