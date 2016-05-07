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

@synthesize mediaPicker;
@synthesize audioPlayer;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSLog(@"Start\n");

	UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleStartTap:)];
	startTap.numberOfTapsRequired = 1;
	UITapGestureRecognizer *stopTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleStopTap:)];
	stopTap.numberOfTouchesRequired = 2;
	stopTap.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:startTap];
	[self.view addGestureRecognizer:stopTap];
}

- (void)handleStartTap:(UITapGestureRecognizer*)sender {
	if (sender.state == UIGestureRecognizerStateEnded) {
		NSLog(@"Hello\n");
		
		self.mediaPicker = [[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeAnyAudio];
		self.mediaPicker.delegate = self;
		[self.mediaPicker setAllowsPickingMultipleItems:false];
		[self presentViewController:self.mediaPicker animated:true completion:nil];
	}
}

- (void)handleStopTap:(UITapGestureRecognizer*)sender {
	if (sender.state == UIGestureRecognizerStateEnded) {
		[self.audioPlayer stop];
	}
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
	[self dismissViewControllerAnimated:true completion:nil];
	
	MPMediaItem *mediaItem = [[mediaItemCollection items]objectAtIndex:0];
	NSURL *url = [mediaItem valueForKey:MPMediaItemPropertyAssetURL];
	NSError *error;
	self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
	self.audioPlayer.meteringEnabled = true;
	[self.audioPlayer play];
	
	self.meterView.audioPlayer = self.audioPlayer;
	[self.meterView setNeedsDisplay];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
	[self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
