//
//  ViewController.m
//  MusicTap
//
//  Created by Muhd Mirza on 6/5/16.
//  Copyright © 2016 muhdmirzamz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize artwork;
@synthesize musicPlayer;
@synthesize mediaQuery;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSLog(@"Start\n");
	
	self.musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
	self.musicPlayer.shuffleMode = MPMusicShuffleModeAlbums;
	self.musicPlayer.repeatMode = MPMusicRepeatModeNone;
	self.mediaQuery = [MPMediaQuery albumsQuery];
	[self.musicPlayer setQueueWithQuery:self.mediaQuery];
	
	UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleStartTap:)];
	startTap.numberOfTapsRequired = 1;
	UITapGestureRecognizer *stopTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleStopTap:)];
	stopTap.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:startTap];
	[self.view addGestureRecognizer:stopTap];
}

- (void)handleStartTap:(UITapGestureRecognizer*)sender {
	if (sender.state == UIGestureRecognizerStateEnded) {
		NSLog(@"Hello\n");
		[self.musicPlayer play];
		
		MPMediaItem *item = [self.musicPlayer nowPlayingItem];
		MPMediaItemArtwork *mpArtwork = [item valueForProperty:MPMediaItemPropertyArtwork];
		self.artwork = [mpArtwork imageWithSize:self.view.frame.size];
		UIImageView *artworkImageView = [[UIImageView alloc]initWithImage:self.artwork];
		artworkImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
		[self.view addSubview:artworkImageView];
	}
}

- (void)handleStopTap:(UITapGestureRecognizer*)sender {
	if (sender.state == UIGestureRecognizerStateEnded) {
		[self.musicPlayer stop];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
