//
//  Difference.h
//  igstd
//
//  Created by Mathias Hodler on 06.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Difference : NSObject {
	CGPoint position;
	CGSize size;
}

-(id)initWithX:(int)_x andY:(int)_y andWidth:(int)_width andHeight:(int)_height;

@property CGPoint position; 
@property CGSize size; 

@end
