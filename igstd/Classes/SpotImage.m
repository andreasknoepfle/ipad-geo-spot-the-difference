//
//  DisplayMap.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpotImage.h"

@implementation SpotImage

@synthesize coordinate,title,subtitle,image,latitude,longitude;


-(id)initWithLongitude:(double)_longitude andLatitude:(double)_latitude andTitle:(NSString *)_title 
		   andSubtitle:(NSString *)_subtitle andImageName:(NSString *) imageName{
	self = [super init];
	
	if(self != nil) {
		self.longitude=_longitude;
		self.latitude=_latitude;
		self.title=_title;
		self.subtitle=_subtitle;
		self.image=[UIImage imageNamed:imageName];
	}
	return self;
}



-(void)dealloc{
	[title release];
	[subtitle release];
	[image release];
	[super dealloc];
}
@end