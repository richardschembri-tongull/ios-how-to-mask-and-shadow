//
//  TJViewController.m
//  MaskAndShadow
//
//  Created by Travis Jeffery on 2012-08-06.
//  Copyright (c) 2012 Travis Jeffery. All rights reserved.
//

#import "TJViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TJViewController ()

@end

@implementation TJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // white bg to see the shadow easier
    self.view.backgroundColor = [UIColor whiteColor];
    
    // the image we're going to mask and shadow
    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sj.jpeg"]];
    image.center = self.view.center;
    
    // make new layer to contain shadow and masked image
    CALayer* containerLayer = [CALayer layer];
    containerLayer.shadowColor = [UIColor blackColor].CGColor;
    containerLayer.shadowRadius = 10.f;
    containerLayer.shadowOffset = CGSizeMake(0.f, 5.f);
    containerLayer.shadowOpacity = 1.f;
    
    // use the image's layer to mask the image into a circle
    //image.layer.cornerRadius = roundf(image.frame.size.width/2.0);
    //image.layer.masksToBounds = YES;
    
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(215.0, 75.0)];
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(20.0, 230.0)];
    [aPath addLineToPoint:CGPointMake(215.0, 280.0)];
    [aPath addLineToPoint:CGPointMake(60.0, 115.0)];
    [aPath addLineToPoint:CGPointMake(80.0, 310.0)];
    [aPath addLineToPoint:CGPointMake(300.0, 150.0)];
    //[aPath addLineToPoint:CGPointMake(85.0, 435.0)];
    [aPath closePath];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar.png"]];
    image.frame = CGRectMake(0, 0, 350, 350);
    [self setClippingPath:aPath :image];
    //[self.view addSubview:image];
    
    // add masked image layer into container layer so that it's shadowed
    [containerLayer addSublayer:image.layer];
    
    // add container including masked image and shadow into view
    [self.view.layer addSublayer:containerLayer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void) setClippingPath:(UIBezierPath *)clippingPath : (UIImageView *)imgView;
{
    if (![[imgView layer] mask])
        [[imgView layer] setMask:[CAShapeLayer layer]];
    
    [(CAShapeLayer*) [[imgView layer] mask] setPath:[clippingPath CGPath]];
}

@end
