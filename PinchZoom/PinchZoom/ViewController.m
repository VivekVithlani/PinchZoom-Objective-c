//
//  ViewController.m
//  PinchZoom
//
//  Created by MacMini on 20/01/17.
//  Copyright © 2017 MacMini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate> {
    
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *imgView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Note: Remove "auto resize" / "constant" from image view
    scrollView.minimumZoomScale = 1;
    scrollView.maximumZoomScale = 6.0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Setup Image view frame
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        CGRect photoImageViewFrame;
        photoImageViewFrame.size = imgView.image.size;
        imgView.frame = photoImageViewFrame;
        scrollView.contentSize = photoImageViewFrame.size;
        
        // Set zoom to minimum zoom, Every time updateZoom method when you change image
        [self updateZoom];
    });
}

-(void)updateZoom {
    scrollView.minimumZoomScale = MIN(scrollView.bounds.size.width / imgView.image.size.width, scrollView.bounds.size.height / imgView.image.size.height);
    /* This is extra code.
    if (scrollView.zoomScale <= scrollView.minimumZoomScale) {
        scrollView.zoomScale = scrollView.minimumZoomScale;
    }
    */
    scrollView.zoomScale = scrollView.minimumZoomScale;
}

- (void)centerScrollViewContents {
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = imgView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    imgView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView1 {
    NSLog(@"scrollViewDidZoom");
    [self centerScrollViewContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
