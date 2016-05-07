//
//  Line.m
//  MusicTap
//
//  Created by Muhd Mirza on 7/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize initialPoint, lastPoint;

- (id)initWithInitialPoint:(CGPoint)initial andLastPoint:(CGPoint)last {
	self = [super init];
	
	if (self) {
		self.initialPoint = initial;
		self.lastPoint = last;
	}
	
	return self;
}

@end
