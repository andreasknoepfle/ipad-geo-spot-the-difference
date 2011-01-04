//
//  DisplayMap.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayMap.h"

@implementation DisplayMap

@synthesize coordinate,title,internalName;

-(void)dealloc{
	[title release];
	[internalName release];
	[super dealloc];
}
@end