//
//  DisplayMap.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpotImage.h"

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

-(id) encodeWithCoder:(NSCoder *)encoder
{
	// nichts machen, da bisher nicht serialisiert werden muss
	return NULL;
}


-(id) initWithCoder:(NSCoder *)decoder
{
	CLLocationCoordinate2D coordinate; 
	NSString * title; 
	NSString * subtitle;
	
	
	//NSString* imageName = 
	
	//image = [UIImage imageNamed:imageName];
	//latitude = [[decoder decodeDoubleForKey:@"Latitude"]];
	//longitude = [[decoder decodeDoubleForKey:@"Longitude"]];
	
	return NULL;
}

-(void)dealloc{
	[title release];
	[subtitle release];
	[image release];
	[super dealloc];
}
@end