//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Austen Johnson on 4/22/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFSelfyViewController.h"
#import "SLFTableViewController.h"

@interface SLFSelfyViewController () <UITextViewDelegate>

@end

@implementation SLFSelfyViewController
{
    UITextView *captionField;
    UIButton * submitButton;
    UIButton * cancelButton;
    UILabel * titleHeader;
    UIImageView * selfyImage;
    UIView * newForm;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:newForm];
        
        titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 90)];
        titleHeader.text = @"\u03a3" @"\u0395" @"\u039B" @"\u03A6" @"\u03A5";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [newForm addSubview:titleHeader];
        
        selfyImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, 260, 200)];
        selfyImage.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        selfyImage.contentMode = UIViewContentModeScaleAspectFit;
        [newForm addSubview:selfyImage];
        
        captionField = [[UITextView alloc] initWithFrame:CGRectMake(30, 310, 260, 60)];
        captionField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        captionField.text = @"";
        captionField.delegate = self;
        captionField.keyboardType = UIKeyboardTypeTwitter;
        [newForm addSubview:captionField];
        
        submitButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 380, 100, 30)];
        [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submitButton) forControlEvents: UIControlEventTouchUpInside];
        submitButton.backgroundColor = [UIColor blackColor];
        submitButton.layer.cornerRadius = 6;
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newForm addSubview:submitButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)submitButton
{
    UIImage * image = [UIImage imageNamed:@"ship"];
    NSData * imageData = UIImagePNGRepresentation(image);
    PFFile * imageFile = [PFFile fileWithName:@"ship.png" data:imageData];
    
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"caption"] = captionField.text;
    newSelfy[@"image"] = imageFile;
    [newSelfy saveInBackground];
}

-(void)tapScreen
{
    [captionField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = self.view.frame;
    }];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -KB_HEIGHT, 320, self.view.frame.size.height);
    }];
    
    return YES;
}

-(void)cancelNewSelfy
{
    SLFTableViewController * cancelView = [[SLFTableViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:cancelView animated:YES];
    
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:cancelView];
    
    nc.navigationBar.barTintColor = [UIColor colorWithRed:0.137f green:0.627f blue:0.906f alpha:1.0];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem * cancelNewSelfy = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector (cancelNewSelfy)];
    
    cancelNewSelfy.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfy;
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
