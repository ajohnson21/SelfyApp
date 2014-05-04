//
//  PLAFilterViewController.h
//  PhotoLibraryApp
//
//  Created by Austen Johnson on 5/1/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLFFilterViewControllerDelegate;

@interface SLFFilterViewController : UIViewController

@property (nonatomic, assign) id<SLFFilterViewControllerDelegate> delegate;

@property (nonatomic) UIImage * imageToFilter;

@end

@protocol SLFFilterViewControllerDelegate <NSObject>

- (void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end
