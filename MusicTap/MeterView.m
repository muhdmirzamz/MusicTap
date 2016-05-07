//
//  MeterView.m
//  MusicTap
//
//  Created by Muhd Mirza on 7/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import "MeterView.h"

@implementation MeterView

@synthesize lineArr;
@synthesize lastPoint;
@synthesize image;

@synthesize audioPlayer;
@synthesize width;
@synthesize threshold;

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CADisplayLink *dl = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
	[dl addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

	self.width = 2;
}

- (void)drawRect:(CGRect)rect {
	// normal drawing
	if (self.image) {
		[self.image drawInRect:rect];
	}

	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.width);
	CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor blueColor]CGColor]);
	
	for (Line *line in self.lineArr) {
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), line.initialPoint.x, line.initialPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), line.lastPoint.x, line.lastPoint.y);
	}
	
	CGContextStrokePath(UIGraphicsGetCurrentContext());

	// the bar
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
	CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor blueColor]CGColor]);
	CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor blueColor]CGColor]);

	if (self.threshold > -130 && self.threshold < -50) {
		self.width = 4;
		
		CGRect r = CGRectMake(50, 200, 20, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > -50 && self.threshold < -30) {
		self.width = 6;
	
		CGRect r = CGRectMake(50, 200, 30, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > -30 && self.threshold < -14) {
		self.width = 8;
	
		CGRect r = CGRectMake(50, 200, 50, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > -14 && self.threshold < -8) {
		self.width = 10;
	
		CGRect r = CGRectMake(50, 200, 70, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > -8 && self.threshold < 0) {
		self.width = 12;
	
		CGRect r = CGRectMake(50, 200, 80, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > 0 && self.threshold < 0.2) {
		self.width = 14;
	
		CGRect r = CGRectMake(50, 200, 90, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > 0.2 && self.threshold < 0.3) {
		self.width = 16;
	
		CGRect r = CGRectMake(50, 200, 100, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else if (self.threshold > 0.3 && self.threshold < 0.4) {
		self.width = 18;
	
		CGRect r = CGRectMake(50, 200, 300, 50);
		
		CGContextFillRect(UIGraphicsGetCurrentContext(), r);
	} else {
		self.width = 2;
	}
	
	NSLog(@"Width: %f\n", self.width);
}

- (void)update {
	if (self.audioPlayer.isPlaying) {
		[self.audioPlayer updateMeters];
		
		self.threshold = [self.audioPlayer peakPowerForChannel:0];
		
		[self setNeedsDisplay];
	}
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	self.lineArr = [NSMutableArray array];

	UITouch *touch = [touches anyObject];
	self.lastPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	Line *line = [[Line alloc]initWithInitialPoint:self.lastPoint andLastPoint:point];
	[self.lineArr addObject:line];
	
	self.lastPoint = point;
	
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
	[self.image drawInRect:self.frame];
	
	for (Line *line in self.lineArr) {
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), line.initialPoint.x, line.initialPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), line.lastPoint.x, line.lastPoint.y);
	}
	
	CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor blueColor]CGColor]);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.width);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	[self.lineArr removeAllObjects];
	
	[self setNeedsDisplay];
}

@end
