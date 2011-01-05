//
//  ImageManager.m
//  igstd
//
//  Created by Markus Holoch on 05.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"


@implementation ImageManager
static ImageManager *imageManager = nil;


+(ImageManager*) getImageManager{

	@synchronized([ImageManager class]){
		if (!imageManager) {
			[[self alloc] init];
		}
		
		return imageManager;
	}
}

+(id) alloc
{
	@synchronized([ImageManager class]){
		NSAssert(imageManager == nil, @"Attempted to allocate a second instance of a singleton");
		imageManager = [super alloc];
		return imageManager;
	}
	
	return nil;
}

-(id) init{
	self = [super init];
	if(self != nil) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		//Pfad zu den Metadatan
		NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Metadata"];
		
		// Alle Dateien ermitteln
		NSArray* files = [fileManager contentsOfDirectoryAtPath:path error:NULL];
		
		// Zum testen ausgeben
		NSLog(path);
		for( NSString* file in files)
		{
			NSLog(file);
		}
		
	}
	
	return self;
}

@end
