//
//  MeterView.h
//  MusicTap
//
//  Created by Muhd Mirza on 7/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import <UIKit/UIKit.h>

@import AVFoundation;
@import CoreGraphics;

#import "Line.h"

@interface MeterView : UIView

@property NSMutableArray *lineArr;
@property CGPoint lastPoint;
@property UIImage *image;

@property float width;
@property float threshold;
@property AVAudioPlayer *audioPlayer;

@end
