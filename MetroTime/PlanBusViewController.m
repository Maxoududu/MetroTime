//
//  PlanBusViewController.m
//  MetroTime
//
//  Created by Pierrick PICON on 24/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import "PlanBusViewController.h"

@interface PlanBusViewController ()
@property (nonatomic, strong) UIImageView *imageView;
- (void)centerScrollViewContents;

@end

@implementation PlanBusViewController;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;

// method witch resize and center the image
- (void)centerScrollViewContents{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) /2.0f;
    }
    else {
        contentsFrame.origin.x = 0.0f;
    }
    
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) /2.0f;
    }
    else {
        contentsFrame.origin.y =0.0f;
    }
    
    self.imageView.frame =contentsFrame;
    
}

// Add the scrollView into the view
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

// call the centerScrollViewContents when
-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //loading the image
	UIImage *image =[UIImage imageNamed:@"PlanBus.gif"];
    self.imageView =[[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.contentSize = image.size;
    
    
}

// custom implementation to save zooming state
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale = minScale;
    
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
