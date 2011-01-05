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

-(void)dealloc{
	[title release];
	[subtitle release];
	[image release];
	[super dealloc];
}
@end