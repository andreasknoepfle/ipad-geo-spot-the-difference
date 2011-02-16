//
//  DisplayMap.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSKeyedArchiver.h>
#import <MapKit/MapKit.h>
#import "Difference.h"


@interface SpotImage : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate; 
	NSString * title; 
	NSString * subtitle;
	UIImage *image;	
	NSMutableArray * differences;
}
-(id)initWithLongitude:(double)longitude andLatitude:(double)latitude andTitle:(NSString *)title 
		   andSubtitle:(NSString *)subtitle andImageName:(NSString *)imageName;

-(id)initWithPlist:(NSString*)path;

-(Difference *) doesHitWithX:(int)x andY:(int)y;
  
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, retain) NSMutableArray * differences;

@end