//
//  DisplayMap.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayMap.h"

@implementation DisplayMap

@synthesize coordinate,title,subtitle;

-(void)dealloc{
	[title release];
	[super dealloc];
}
@end