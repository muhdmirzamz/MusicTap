//
//  ViewController.h
//  MusicTap
//
//  Created by Muhd Mirza on 6/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MediaPlayer;
@import AVFoundation;

#import "MeterView.h"

@interface ViewController : UIViewController<MPMediaPickerControllerDelegate>

@property MPMediaPickerController *mediaPicker;
@property AVAudioPlayer *audioPlayer;

@property IBOutlet MeterView *meterView;

@end

