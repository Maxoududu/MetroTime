//
//  PlanMetroViewController.m
//  MetroTime
//
//  Created by Maxime Dupuy on 24/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import "PlanMetroViewController.h"

@interface PlanMetroViewController ()

@property (nonatomic, strong) UIImageView *imageView;
- (void)centerScrollViewContents;

@end

@implementation PlanMetroViewController;
@synthesize imageView = _imageView;
@synthesize scrollView = _scrollView;

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

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImage *image =[UIImage imageNamed:@"PlanMetro.png"];
    self.imageView =[[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.contentSize = image.size;
    
    
}
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
