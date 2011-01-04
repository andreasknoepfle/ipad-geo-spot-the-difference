//
//  UIImage+Resizing.m
//  igstd
//
//  Created by apfel on 1/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Resizing.h"


@implementation UIImage (Resizing)

- (UIImage*) getThumbnailWithSize:(int)maxsize {
	CGSize size;
	if (self.size.height<self.size.width) {
		if(self.size.width>maxsize) {
		    double factor=self.size.width/maxsize;
			int height=self.size.height/factor;
			size=CGSizeMake(maxsize, height);
		} else {
			return self;
		}
	} else {
		if(self.size.height>maxsize) {
		    double factor=self.size.height/maxsize;
			int width=self.size.width/factor;
			size=CGSizeMake(width, maxsize);
		} else {
			return self;
		}
	}
	UIGraphicsBeginImageContext(size);
	[self drawInRect:CGRectMake(0.0f,0.0f,size.width,size.height)];
	UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resizedImage;
}

@end
