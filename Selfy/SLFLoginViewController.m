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
#import "SLFTableViewController.h"
#import "SLFSignUpViewController.h"
#import "SLFNewNavigationController.h"

@interface SLFLoginViewController () <UITextFieldDelegate>

@end

@implementation SLFLoginViewController
{
    UITextField * nameField;
    UITextField * password;
    UIButton * signInButton;
    UILabel *titleHeader;
    UIView * loginForm;
    UIAlertView * alert;
    UIButton * signUpButton;
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

        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 200, 200, 40)];
        nameField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        nameField.placeholder = @" username";
        nameField.layer.cornerRadius = 6;
        nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        nameField.autocorrectionType = UITextAutocorrectionTypeNo;
        nameField.keyboardType = UIKeyboardTypeTwitter;
        [loginForm addSubview:nameField];
        nameField.delegate = self;
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(60, 250, 200, 40)];
        password.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        password.secureTextEntry = YES;
        password.placeholder = @" password";
        password.layer.cornerRadius = 6;
        password.keyboardType = UIKeyboardTypeTwitter;
        [loginForm addSubview:password];
        password.delegate = self;
        
        signInButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 200, 40)];
        [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
        [signInButton addTarget:self action:@selector(signInButton) forControlEvents: UIControlEventTouchUpInside];
        signInButton.backgroundColor = [UIColor blueColor];
        signInButton.layer.cornerRadius = 6;
        signInButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginForm addSubview:signInButton];
        
        signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 350, 200, 40)];
        [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [signUpButton addTarget:self action:@selector(showSignUp) forControlEvents: UIControlEventTouchUpInside];
        signUpButton.backgroundColor = [UIColor lightGrayColor];
        signUpButton.layer.cornerRadius = 6;
        signUpButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginForm addSubview:signUpButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        
    }
    return self;
}

-(void)showSignUp
{
    SLFSignUpViewController * signUpVC = [[SLFSignUpViewController alloc] initWithNibName:nil bundle:nil];
    
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:signUpVC];
    
    nc.navigationBar.barTintColor = [UIColor colorWithRed:0.137f green:0.627f blue:0.906f alpha:1.0];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];
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
    [self hideKeyboard];
    
    UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    [activity setColor:[UIColor orangeColor]];
    activity.color = [UIColor orangeColor];
    activity.frame = CGRectMake(0, 300, self.view.frame.size.width, 50);
    
    [loginForm addSubview:activity];

    [activity startAnimating];
    
    [nameField resignFirstResponder];
    [password resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        loginForm.frame = self.view.frame;
    }];

        [PFUser logInWithUsernameInBackground:nameField.text password:password.text block:^(PFUser *user, NSError *error) {
        
//            NSLog(@"logged in", user.username);
//            NSLog(@"current user %@", [PFUser currentUser].username);
            
        if (error == nil)
        {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
        }
        else
        {
            password.text = nil;
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorDescription delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            [alertView show];
            
            [activity removeFromSuperview];

            
        }

    }];
    
}

-(void)hideKeyboard
{
    [nameField resignFirstResponder];
    [password resignFirstResponder];
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
