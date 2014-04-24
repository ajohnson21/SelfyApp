//
//  SLFLoginViewController.m
//  Selfy
//
//  Created by Austen Johnson on 4/22/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//


#import <Parse/Parse.h>

#import "SLFLoginViewController.h"
#import "SLFSelfyViewController.h"

@interface SLFLoginViewController () <UITextFieldDelegate>

@end

@implementation SLFLoginViewController
{
    UITextField * nameField;
    UITextField * password;
    UIButton * signInButton;
    UILabel *titleHeader;
    UIView * loginForm;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        loginForm = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:loginForm];
        
        
        titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 90)];
        titleHeader.text = @"\u03a3" @"\u0395" @"\u039B" @"\u03A6" @"\u03A5";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [loginForm addSubview:titleHeader];

        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 200, 200, 30)];
        nameField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        nameField.placeholder = @" username";
        nameField.layer.cornerRadius = 6;
        nameField.keyboardType = UIKeyboardTypeTwitter;
        [loginForm addSubview:nameField];
        nameField.delegate = self;
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(60, 240, 200, 30)];
        password.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        password.secureTextEntry = YES;
        password.placeholder = @" password";
        password.layer.cornerRadius = 6;
        password.keyboardType = UIKeyboardTypeTwitter;
        [loginForm addSubview:password];
        password.delegate = self;
        
        signInButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 280, 100, 30)];
        [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
        [signInButton addTarget:self action:@selector(signInButton) forControlEvents: UIControlEventTouchUpInside];
        signInButton.backgroundColor = [UIColor clearColor];
        signInButton.layer.cornerRadius = 6;
        signInButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginForm addSubview:signInButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        
    }
    return self;
}

-(void)tapScreen
{
    [nameField resignFirstResponder];
    [password resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        loginForm.frame = self.view.frame;
    }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        loginForm.frame = CGRectMake(0, -KB_HEIGHT /2, 320, self.view.frame.size.height);
    }];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)signInButton
{
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    PFUser * user = [PFUser currentUser];
    
    user.username = nameField.text;
    user.password = password.text;
    
    [user saveInBackground];
    
    NSLog(@"testing submit button");
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

@end
