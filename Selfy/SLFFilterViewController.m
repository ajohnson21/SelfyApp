//
//  PLAFilterViewController.m
//  PhotoLibraryApp
//
//  Created by Austen Johnson on 5/1/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFFilterViewController.h"
#import "SLFSelfyViewController.h"
#import "SLFTableViewController.h"


@interface SLFFilterViewController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation SLFFilterViewController
{
    UIScrollView * scrollview;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
    
    float wh;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor clearColor];
        
        
        filterButtons = [@[] mutableCopy];
        filterNames = @[
                        @"CIColorInvert",
                        @"CIColorMonochrome",
                        @"CIColorPosterize",
                        @"CIFalseColor",
                        @"CIMaximumComponent",
                        @"CIMinimumComponent",
                        @"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade",
                        @"CIPhotoEffectInstant",
                        @"CIPhotoEffectMono",
                        @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess",
                        @"CIPhotoEffectTonal",
                        @"CIPhotoEffectTransfer",
                        @"CISepiaTone",
                        @"CIVignette"
                        ];
        
        
        scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        scrollview.backgroundColor = [UIColor blackColor];
        [self.view addSubview:scrollview];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    // Do any additional setup after loading the view.
    
    wh = self.view.frame.size.height -20;
    
//            NSInteger numOfViews = 20;
    
        for (NSString * filterName in filterNames)
        {
            int i = (int)[filterNames indexOfObject:filterName];
            int x = (wh + 10) * i + 10;
    
            UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 10, wh, wh)];
            filterButton.tag = i;
            filterButton.backgroundColor = [UIColor whiteColor];
            [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
            [filterButtons addObject:filterButton];
            [scrollview addSubview:filterButton];
    
        }
    
//        scrollview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrollview.backgroundColor = [UIColor darkGrayColor];
        scrollview.contentSize = CGSizeMake((wh + 10) * [filterNames count] + 10, self.view.frame.size.height);

    
}

-(UIImage *)shrinkImage:(UIImage *)image maxWH:(int)widthHeight
{
    CGSize size = CGSizeMake(widthHeight, widthHeight / image.size.width * image.size.height);
    
    if (image.size.height < image.size.width)
    {
        size = CGSizeMake(widthHeight / image.size.height * image.size.width, widthHeight);
        
    }
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImage;
    
}

-(void)switchFilter:(UIButton *)filterButton
{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
    
    
    
    
    //    [self.delegate updateCurrentImageWithFilteredImage:[UIImage imageWithCGImage:[self filterImage: [self shrinkImage: self.imageToFilter maxWH:SCREEN_WIDTH * 2] filterName: self.currentFilter]]];
}

-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
{
    
    CIImage * CiImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    [filter setValue:CiImage forKeyPath:kCIInputImageKey];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}

-(void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
    
    for (UIButton * filterButton in filterButtons)
    {
//        [filterButton setImage:nil forState:UIControlStateNormal];
        
        NSString * filterName = [filterNames objectAtIndex:filterButton.tag];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{
            UIImage * smallImage = [self shrinkImage:imageToFilter maxWH:wh];
            UIImage * image = [self filterImage:smallImage filterName:filterName];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [filterButton setImage:image forState:UIControlStateNormal];
                filterButton.contentMode = UIViewContentModeScaleAspectFill;
                
            });
            
        });
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
