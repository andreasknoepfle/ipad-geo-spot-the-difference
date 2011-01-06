//
//  Difference.m
//  igstd
//
//  Created by Mathais Hodler on 06.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Difference.h"


@implementation Difference

@synthesize position, size;

-(id)initWithX:(int)_x andY:(int)_y andWidth:(int)_width andHeight:(int)_height{
	[self init];
	
	self.size = CGSizeMake(_width, _height);
	self.position = CGPointMake(_x, _y);
	
	return self;
}

@end
