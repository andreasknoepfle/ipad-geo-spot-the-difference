//
//  DisplayMap.h
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface DisplayMap : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *internalName;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *internalName;

@end