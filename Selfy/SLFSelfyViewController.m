//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Austen Johnson on 4/22/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFSelfyViewController.h"

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
    selfyImage.image = [UIImage imageNamed:@"boss"];
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
    [self createForm];
}

-(void)cancelNewSelfy
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIBarButtonItem * cancelNewSelfy = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector (cancelNewSelfy)];
    
    cancelNewSelfy.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfy;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
