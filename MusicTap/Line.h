//
//  Line.h
//  MusicTap
//
//  Created by Muhd Mirza on 7/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

@interface Line : NSObject

@property CGPoint initialPoint;
@property CGPoint lastPoint;

- (id)initWithInitialPoint:(CGPoint)initial andLastPoint:(CGPoint)last;

@end
