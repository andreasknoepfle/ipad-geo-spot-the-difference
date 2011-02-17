//
//  SecondViewController.m
//  igstd
//
//  Created by apfel on 1/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageManager.h"
#import "Difference.h"


@implementation ImageViewController

@synthesize scrollView, imageView, spotImage, foundDiffs,allDiffs, foundDiffsArray,backupImage;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	foundDiffsArray=[[NSMutableArray alloc] init];
}	

// Diesen View als First Responder deklarieren
- (BOOL) canBecomeFirstResponder {
	return YES;
}
-(void) viewDidAppear:(BOOL)animated {
	[self becomeFirstResponder];	
	
}

- (void) updateScrollView{	
	scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
	scrollView.maximumZoomScale = 2.0;
	scrollView.minimumZoomScale = 1.0;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	[scrollView addSubview:imageView];
	
	// Initial zentrieren
	[self scrollViewDidZoom:scrollView];
}

- (void) resetScrollView{
	// Alle vorherigen Subviews loeschen
	for (UIView *view in [scrollView subviews]) {
		[view removeFromSuperview];
	}
	
	//Bounds zuruecksetzen
	scrollView.bounds = scrollView.frame;
}

// Zentriert das Image im ScrollView
-(void)scrollViewDidZoom:(UIScrollView *)pScrollView {
	CGRect innerFrame = imageView.frame;
	CGRect scrollerBounds = pScrollView.bounds;
	
	if ( ( innerFrame.size.width < scrollerBounds.size.width ) || ( innerFrame.size.height < scrollerBounds.size.height ) )
	{
		CGFloat tempx = imageView.center.x - ( scrollerBounds.size.width / 2 );
		CGFloat tempy = imageView.center.y - ( scrollerBounds.size.height / 2 );
		CGPoint myScrollViewOffset = CGPointMake( tempx, tempy);
		
		pScrollView.contentOffset = myScrollViewOffset;
		
	}
	
	UIEdgeInsets anEdgeInset = { 0, 0, 0, 0};
	if ( scrollerBounds.size.width > innerFrame.size.width )
	{
		anEdgeInset.left = (scrollerBounds.size.width - innerFrame.size.width) / 2;
		anEdgeInset.right = -anEdgeInset.left;  // I don't know why this needs to be negative, but that's what works
	}
	if ( scrollerBounds.size.height > innerFrame.size.height )
	{
		anEdgeInset.top = (scrollerBounds.size.height - innerFrame.size.height) / 2;
		anEdgeInset.bottom = -anEdgeInset.top;  // I don't know why this needs to be negative, but that's what works
	}
	pScrollView.contentInset = anEdgeInset;
}



- (void) showSpotImage{	
	[self resetScrollView];
	
	// ImageView mit einem Bild erstellen
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:spotImage.image];
	[self setImageView: tempImageView];
	[tempImageView release];
	
	// Seitenverhaeltnis des Bildes ermitteln
	double aspectRatio = spotImage.image.size.width / spotImage.image.size.height;
	
	// Variablen fuer die spaetere Zuweisung des imageView Frames
	int width = 0;
	int height = 0;
	
	// Je nachdem welche Seite des Bild die groessere ist, wird das 
	// ImageView an die ScrollView perfekt angepasst
	if (aspectRatio >1 ) {
		// Breite > Hoehe
		width = scrollView.bounds.size.width;
		height = width / aspectRatio;
	}
	else{
		// Hoehe > Breite
		height = scrollView.bounds.size.height;
		width = height * aspectRatio;
	}
	
	
	imageView.frame = CGRectMake(0,0, width, height);
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.userInteractionEnabled = true;
	imageView.clipsToBounds = true;
		
	UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]; 
	[imageView addGestureRecognizer:longPressGesture];
	[foundDiffsArray removeAllObjects];
	[foundDiffs setText: [NSString stringWithFormat:@"%i",[foundDiffsArray count]]];
	[allDiffs setText: [NSString stringWithFormat:@"%i",[spotImage.differences count]]];
		
	[self updateScrollView];
	UIGraphicsBeginImageContext(self.imageView.frame.size);
	[self.imageView.image drawInRect:CGRectMake(0,0,self.imageView.frame.size.width,self.imageView.frame.size.height)];
	backupImage = UIGraphicsGetImageFromCurrentImageContext();
	[backupImage retain];
	UIGraphicsEndImageContext();

}

- (void) longPress:(UILongPressGestureRecognizer*)gesture{
	

	if (gesture.state == UIGestureRecognizerStateBegan) {
		// Relative Position des Clicks zum ImageView ermitteln
		int x = [gesture locationInView:scrollView].x;
		int y = [gesture locationInView:scrollView].y;
		
		// Verhaeltnis der Groesse des Originalbildes zum ImageView ermitteln
		float aspectWidth = spotImage.image.size.width / imageView.frame.size.width;
		float aspectHeight = spotImage.image.size.height / imageView.frame.size.height; 
		
		int absX = aspectWidth * x;
		int absY = aspectHeight * y;
		
		Difference* hitted = [spotImage doesHitWithX:absX andY:absY];
		
		if (hitted!=nil) {
			int index =[foundDiffsArray indexOfObject:hitted];
			//Nur wenn noch nicht schon gehitted
			if(index==NSNotFound) { 
				//Treffer 
				// Loesche alte Tipps durch Backup
				self.imageView.image = self.backupImage;
				UIGraphicsBeginImageContext(self.imageView.frame.size);
				//Zeichne Rechteck
				CGContextRef ctx= UIGraphicsGetCurrentContext();
				[self.imageView.image drawInRect:CGRectMake(0,0,self.imageView.frame.size.width,self.imageView.frame.size.height)];
				CGContextSetRGBFillColor(ctx, 0.0,1.0,0.0,0.5);
				CGContextFillRect(ctx,CGRectMake(hitted.position.x/aspectWidth,hitted.position.y/aspectHeight,hitted.size.width/aspectWidth,hitted.size.height/aspectHeight));
				imageView.image = UIGraphicsGetImageFromCurrentImageContext();
				backupImage = UIGraphicsGetImageFromCurrentImageContext();
				[backupImage retain];
				UIGraphicsEndImageContext();
				[foundDiffsArray addObject:hitted];
				[foundDiffs setText: [NSString stringWithFormat:@"%i",[foundDiffsArray count]]];
			}
		}
	}
}
							  

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
	// Falls das imageView kleiner wird als das Scrollview so wird es
	// auf die ideale groesse vergroessert
	//TODO
	
	// imageView zurueckgeben, damit das Scrollview sein content darauf anpasst
	return imageView;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[backupImage release];
	[scrollView release];
	[imageView release];
    [super dealloc];
}

// Schuetteln fuer Tipps
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	// Verhaeltnis der Groesse des Originalbildes zum ImageView ermitteln
	float aspectWidth = spotImage.image.size.width / imageView.frame.size.width;
	float aspectHeight = spotImage.image.size.height / imageView.frame.size.height; 
	
	if (event.type == UIEventSubtypeMotionShake) {
		for(Difference* diff in spotImage.differences){
			int index =[foundDiffsArray indexOfObject:diff];
			//Nur nicht gefundene Fehler
			if(index==NSNotFound) { 
				//Image ohne Tipp laden
				self.imageView.image = self.backupImage;
				UIGraphicsBeginImageContext(self.imageView.frame.size);
				
				[self.imageView.image drawInRect:CGRectMake(0,0,self.imageView.frame.size.width,self.imageView.frame.size.height)];
				
				CGContextRef ctx= UIGraphicsGetCurrentContext();
				
								
				// Einen zufaelligen Rahmen um den Unterschied ziehen
				int randx=diff.position.x-(arc4random()%10)*spotImage.image.size.width/20;
				if(randx<0)
					randx=0;
				int randy=diff.position.y-(arc4random()%10)*spotImage.image.size.height/20;
				if(randy<0)
					randy=0;
				
				
				
				int randw=diff.size.width+(diff.position.x-randx)+(arc4random()%10)*spotImage.image.size.width/20;
				if((randx+randw)>spotImage.image.size.width)
					randw=spotImage.image.size.width-randx;
				
				
				int randh=diff.size.height+(diff.position.y-randy)+(arc4random()%10)*spotImage.image.size.height/20;
				if((randy+randh)>spotImage.image.size.height)
					randh=spotImage.image.size.height-randy;
				
				int x=randx/aspectWidth;
				int y=randy/aspectHeight;
				int w=randw/aspectWidth;
				int h=randh/aspectHeight;
				CGContextSetLineWidth(ctx, 1);
				CGContextSetRGBStrokeColor(ctx, 1.0,1.0,1.0,1.0);
				CGContextStrokeRect(ctx,CGRectMake(x,y,w,h));
				CGContextSetRGBStrokeColor(ctx, 0,0,0,1.0);
				CGContextStrokeRect(ctx,CGRectMake(x-1,y-1,w-1,h-1));
				imageView.image = UIGraphicsGetImageFromCurrentImageContext();
				
				//Nur einen Tipp geben
				UIGraphicsEndImageContext();
				break;
			}
		}
	}
}

@end
