//
//  ImageManager.h
//  igstd
//
//  Created by Mathias Hodler on 05.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageManager : NSObject {
	NSMutableArray* spotImages;
}

+(ImageManager*) getImageManager;

@property (nonatomic, retain) NSMutableArray* spotImages; 

@end
