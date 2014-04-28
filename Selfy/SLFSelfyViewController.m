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

@synthesize imageTable;

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
    
//    selfyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 220)];
//    selfyImage.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
//    [selfyImage setImage:[UIImage imageNamed:@"movie_reel.png"]];
//    selfyImage.contentMode = UIViewContentModeScaleAspectFit;
//    [newForm addSubview:selfyImage];
    
    selfyImage = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 220)];
    selfyImage.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [selfyImage setImage:[UIImage imageNamed:@"movie_reel.png"]];
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

    UIImage * image = [UIImage imageNamed:@"movie_reel.png"];
    NSData * imageData = UIImagePNGRepresentation(image);
    PFFile * imageFile = [PFFile fileWithName:@"movie_reel.png" data:imageData];

    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"caption"] = captionField.text;
    newSelfy[@"image"] = imageFile;
    [newSelfy saveInBackground];
    
    PFQuery * query = [PFQuery queryWithClassName:@"UserSelfy"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", objects);
        NSLog(@"testing");
        if (!error) {
            imageArray = [[NSArray alloc] initWithArray:objects];
        }
        [imageTable reloadData];
    }];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)retrieveFromParse
{

//    PFQuery * query = [PFQuery queryWithClassName:@"UserSelfy"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
////        NSLog(@"%@", objects);
//        NSLog(@"testing");
//        if (!error) {
//            imageArray = [[NSArray alloc] initWithArray:objects];
//        }
//        [imageTable reloadData];
//    }];
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
    
//    [self performSelector:@selector(submitButton)];
    
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
