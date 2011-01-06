//
//  UITouchImage.m
//  igstd
//
//  Created by Mathias Hodler on 06.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITouchImageView.h"


@implementation UITouchImageView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
    }
    return self;
}

- (id) initWithImage:(UIImage *)image{
	self = [super initWithImage:image];
	
	if(self){
		self.userInteractionEnabled = true;
	}
	return self;
}


- (BOOL) canBecomeFirstResponder{
	return true;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	NSLog(@"TOUCH DOWN");

	NSSet *allTouches = [event allTouches];
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
