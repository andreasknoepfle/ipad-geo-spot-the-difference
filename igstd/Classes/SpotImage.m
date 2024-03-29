//
//  DisplayMap.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpotImage.h"
#import "Foundation/NSDictionary.h"
#import "Difference.h"

@implementation SpotImage

@synthesize coordinate,title,subtitle,image,differences;


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
		differences = [[NSMutableArray alloc] init];
	}
	return self;
}

-(Difference*)doesHitWithX:(int)x andY:(int)y{
	for(Difference* diff in differences){
		if (x>= diff.position.x && x<= diff.position.x + diff.size.width &&
			y >= diff.position.y && y <= diff.position.y + diff.size.height) {
			return diff;
		}
	}
	
	return nil;
}

-(id) initWithPlist:(NSString *)path{
	self = [super init];
	
	differences = [[NSMutableArray alloc] init];
	
	NSDictionary* data = [NSDictionary dictionaryWithContentsOfFile:path];
	
	// Beschriftung einlesen
	self.title = [data objectForKey:@"Title"];
	//self.subtitle = [data objectForKey:@"Description"];

	// Bild einlesen
	NSString* imagePath = [[[NSBundle mainBundle]  resourcePath] stringByAppendingString:@"/Images/"];
	NSString* imageName = [data objectForKey:@"ImagePath"];
	self.image = [UIImage imageWithContentsOfFile:[imagePath stringByAppendingString: imageName]];
	
	// Koordinaten einlesen
	NSNumber* latitude = [data objectForKey:@"Latitude"];
	NSNumber* longitude = [data objectForKey:@"Longitude"];
	MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
	region.center.latitude = [latitude doubleValue];
	region.center.longitude = [longitude doubleValue];
	self.coordinate = region.center;
	
	// Fehlerpunkte einlesen
	id diffs = [data objectForKey:@"Differences"];
	for(NSDictionary *dict in diffs)
	{
		int x = [[dict objectForKey:@"X"] intValue];
		int y = [[dict objectForKey:@"Y"] intValue];
		int width = [[dict objectForKey:@"Width"] intValue];
		int height = [[dict objectForKey:@"Height"] intValue];
		
		Difference* difference = [[Difference alloc] initWithX:x andY:y andWidth:width andHeight:height];
		
		[differences addObject:difference];
	}
	self.subtitle = [NSString stringWithFormat:@"%i Unterschiede",[differences count]];
	return self;
}



-(void)dealloc{
	[title release];
	[subtitle release];
	[image release];
	[super dealloc];
}
@end