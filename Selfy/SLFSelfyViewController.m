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
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:newForm];
        
        titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 90)];
        titleHeader.text = @"\u03a3" @"\u0395" @"\u039B" @"\u03A6" @"\u03A5";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [newForm addSubview:titleHeader];
        
        selfyImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, 260, 200)];
        selfyImage.backgroundColor = [UIColor grayColor];
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
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 25, 20, 20)];
        [cancelButton setTitle:@"X" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButton2) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [newForm addSubview:cancelButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
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

     -(void)cancelButton2
     {
         //
     }
     
     -(void)submitButton
     {
         //
     }
     
     - (void)viewDidLoad
     {
         [super viewDidLoad];
         // Do any additional setup after loading the view.
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
