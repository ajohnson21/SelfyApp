//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Austen Johnson on 4/22/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFSelfyViewController.h"


@interface SLFSelfyViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) UIImage * originalImage;


@end

@implementation SLFSelfyViewController
{
    UITextView *captionField;
    UIButton * submitButton;
    UIButton * cancelButton;
    UILabel * titleHeader;
    UIImageView * selfyImage;
    UIView * newForm;
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
        
        
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:newForm];
        
//        filterButtons = [@[] mutableCopy];
//        filterNames = @[
//                        @"CIColorInvert",
//                        @"CIColorMonochrome",
//                        @"CIColorPosterize",
//                        @"CIFalseColor",
//                        @"CIMaximumComponent",
//                        @"CIMinimumComponent",
//                        @"CIPhotoEffectChrome",
//                        @"CIPhotoEffectFade",
//                        @"CIPhotoEffectInstant",
//                        @"CIPhotoEffectMono",
//                        @"CIPhotoEffectNoir",
//                        @"CIPhotoEffectProcess",
//                        @"CIPhotoEffectTonal",
//                        @"CIPhotoEffectTransfer",
//                        @"CISepiaTone",
//                        @"CIVignette"
//                        ];
//        
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)createForm
{
    
    newForm = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 280, self.view.frame.size.height - 40)];
    [self.view addSubview:newForm];
    
        selfyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 220)];
        selfyImage.backgroundColor = [UIColor whiteColor];
//        selfyImage.image = [UIImage imageNamed:@"boss"];
        selfyImage.contentMode = UIViewContentModeScaleAspectFit;
        [newForm addSubview:selfyImage];
    
        captionField = [[UITextView alloc] initWithFrame:CGRectMake(0, 240, 280, 80)];
        captionField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        captionField.text = @"";
        captionField.delegate = self;
        captionField.keyboardType = UIKeyboardTypeTwitter;
        [newForm addSubview:captionField];
    
    submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0 ,newForm.frame.size.height - 40, 280, 40)];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButton) forControlEvents: UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor blackColor];
    submitButton.layer.cornerRadius = 6;
    submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newForm addSubview:submitButton];
    
    
    //    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    //    scrollview.backgroundColor = [UIColor blackColor];
    //    [self.view addSubview:scrollview];
    
    
}

-(void)submitButton
{
    // connect current user to submitButton as parent : Parse "relational data"
    
    NSData * imageData = UIImagePNGRepresentation(selfyImage.image);
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"caption"] = captionField.text;
    newSelfy[@"image"] = imageFile;
    newSelfy[@"parent"] = [PFUser currentUser];
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%u",succeeded);
        [self cancelNewSelfy];
    }];
    
}

-(void)tapScreen
{
    [captionField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(20, 20, 280, self.view.frame.size.height - 40);
    }];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(20, (20 - KB_HEIGHT), 280, self.view.frame.size.height - 40);
    }];
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self createForm];
}

-(void)cancelNewSelfy
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLayoutSubviews
{
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    wh = self.view.frame.size.height -20;
    //
    //
    //    for (NSString * filterName in filterNames)
    //    {
    //        int i = (int)[filterNames indexOfObject:filterName];
    //        int x = (wh + 10) * i + 10;
    //
    //        UIButton * filterButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 10, wh, wh)];
    //        filterButton.tag = i;
    //        filterButton.backgroundColor = [UIColor whiteColor];
    //        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
    //        [filterButtons addObject:filterButton];
    //        [scrollview addSubview:filterButton];
    //
    //        scrollview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //        scrollview.contentSize = CGSizeMake((wh + 10) * [filterNames count] + 10, self.view.frame.size.height);
    
    
    [self createForm];

    
    UIBarButtonItem * cancelNewSelfy = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector (cancelNewSelfy)];
    
    cancelNewSelfy.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfy;
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem * pickPhoto = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(pickPhoto)];
    
    pickPhoto.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = pickPhoto;
    [self setNeedsStatusBarAppearanceUpdate];
    

    
}

-(void) pickPhoto
{
    UIImagePickerController * photoLibrary = [[UIImagePickerController alloc] init];
    photoLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoLibrary.delegate = self;
    [self presentViewController:photoLibrary animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    selfyImage.image = originalImage;
    
    NSLog(@"%@", self.originalImage);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
