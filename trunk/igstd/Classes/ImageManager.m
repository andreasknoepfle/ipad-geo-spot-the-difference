//
//  ImageManager.m
//  igstd
//
//  Created by Markus Holoch on 05.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"
#import "SpotImage.h"


@implementation ImageManager

@synthesize spotImages;

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
		spotImages = [[NSMutableArray alloc] init];
		
		// FileManager erstellen um den Inhalt eines Verzeichnisses auszulesen
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		// Pfad zu den Metadatan
		NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Metadata/"];
		
		// Alle Dateien ermitteln
		NSArray* files = [fileManager contentsOfDirectoryAtPath:path error:NULL];
		
		for( NSString* file in files)
		{
			if([file hasSuffix:@".plist"]){
				NSString* completePath = [path stringByAppendingString:file];
				SpotImage* spotImage = [[SpotImage alloc] initWithPlist:completePath];
				[spotImages addObject:spotImage];
			}
		}
		
	}
	
	return self;
}

@end
