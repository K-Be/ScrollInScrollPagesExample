//
//  ViewController.m
//  ScrollInScrollPages
//
//  Created by Andrew Romanov on 01/12/2016.
//  Copyright © 2016 Home. All rights reserved.
//

#import "ViewController.h"
#import <KeepLayout.h>

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView* parentScrollView;

@property (nonatomic, strong) UIScrollView* firstScrollChild;
@property (nonatomic, strong) UIImageView* firstContentImageView;

@property (nonatomic, strong) UIScrollView* secondScrollChild;
@property (nonatomic, strong) UIImageView* secondContentImageView;

@end


@interface ViewController (Private)

- (UIImageView*)_createContentImageWithImageNamed:(NSString*)imageName;
- (UIScrollView*)_createScrollViewWithContentView:(UIImageView*)contentView;

@end


@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_firstContentImageView = [self _createContentImageWithImageNamed:@"1.jpg"];
	_firstScrollChild = [self _createScrollViewWithContentView:_firstContentImageView];
	
	_secondContentImageView = [self _createContentImageWithImageNamed:@"2.jpg"];
	_secondScrollChild = [self _createScrollViewWithContentView:_secondContentImageView];
	
	
	[_parentScrollView addSubview:_firstScrollChild];
	[_parentScrollView addSubview:_secondScrollChild];
	
	_firstScrollChild.keepSizeTo(self.view).equal = 1.0;
	_firstScrollChild.keepLeftInset.equal = 0.0;
	_firstScrollChild.keepVerticalInsets.equal = 0.0;
	_firstScrollChild.keepRightOffsetTo(_secondScrollChild).equal = 0.0;
	
	_secondScrollChild.keepSizeTo(self.view).equal = 1.0;
	_secondScrollChild.keepVerticalInsets.equal = 0.0;
	_secondScrollChild.keepRightInset.equal = 0.0;
	
	[_firstContentImageView keepCentered];
	[_secondContentImageView keepCentered];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	UIView* view = nil;
	if (scrollView == _firstScrollChild)
	{
		view = _firstContentImageView;
	}
	else if (scrollView == _secondScrollChild)
	{
		view = _secondContentImageView;
	}
	
	return view;
}


@end


#pragma mark -
@implementation ViewController (Private)

- (UIImageView*)_createContentImageWithImageNamed:(NSString*)imageName
{
	UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
	imageView.backgroundColor = [UIColor redColor];
	imageView.userInteractionEnabled = NO;
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	CGRect frame = imageView.frame;
	frame.size = [UIScreen mainScreen].bounds.size;
	imageView.frame = frame;
	
	return imageView;
}


- (UIScrollView*)_createScrollViewWithContentView:(UIImageView*)contentView
{
	UIScrollView* scroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	scroll.minimumZoomScale = 0.5;
	scroll.maximumZoomScale = 3.0;
	[scroll addSubview:contentView];
	scroll.delegate = self;
	
	return scroll;
}

@end
