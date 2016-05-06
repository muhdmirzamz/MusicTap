//
//  ViewController.h
//  MusicTap
//
//  Created by Muhd Mirza on 6/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MediaPlayer;

@interface ViewController : UIViewController

@property UIImage *artwork;

@property MPMusicPlayerController *musicPlayer;
@property MPMediaQuery *mediaQuery;

@end

