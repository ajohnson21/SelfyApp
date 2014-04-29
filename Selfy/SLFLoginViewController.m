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
    UILabel * orLabel;
    UIButton * singUpButton;
    UIView * signUpView;
    UITextField * displayName;
    UITextField * signUpPassword;
    UITextField * signUpEmail;
    UIButton * submitLoginButton;
    UIButton * cancelLoginButton;
    UIImageView * avatar;
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
        nameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        nameField.autocorrectionType = UITextAutocorrectionTypeNo;
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
        
        orLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 320, 100, 30)];
        orLabel.backgroundColor = [UIColor clearColor];
        orLabel.text = @"OR";
        orLabel.textColor = [UIColor blackColor];
        [loginForm addSubview:orLabel];
        
        singUpButton = [[UIButton alloc] initWithFrame:CGRectMake(110, 360, 100, 30)];
        [singUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [singUpButton addTarget:self action:@selector(signUpButton) forControlEvents: UIControlEventTouchUpInside];
        singUpButton.backgroundColor = [UIColor clearColor];
        singUpButton.layer.cornerRadius = 6;
        singUpButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [singUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginForm addSubview:singUpButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        

    }
    return self;
}

-(void)signUpButton
{
    signUpView = [[UIView alloc] initWithFrame:self.view.frame];
    signUpView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signUpView];
    
    displayName = [[UITextField alloc] initWithFrame:CGRectMake(60, 100, 200, 30)];
    displayName.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    displayName.textColor = [UIColor blackColor];
    displayName.placeholder = @"First and Last Name";
//    displayName.layer.cornerRadius = 6;
    displayName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    displayName.autocorrectionType = UITextAutocorrectionTypeNo;
    [signUpView addSubview:displayName];
    
    signUpPassword = [[UITextField alloc] initWithFrame:CGRectMake(60, 160, 200, 30)];
    signUpPassword.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    signUpPassword.textColor = [UIColor blackColor];
    signUpPassword.placeholder = @"Password";
//    signUpPassword.layer.cornerRadius = 6;
    signUpPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    signUpPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    [signUpView addSubview:signUpPassword];
    
    signUpEmail = [[UITextField alloc] initWithFrame:CGRectMake(60, 220, 200, 30)];
    signUpEmail.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    signUpEmail.textColor = [UIColor blackColor];
    signUpEmail.placeholder = @"email@example.com";
//    signUpEmail.layer.cornerRadius = 6;
    signUpEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    signUpEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    [signUpView addSubview:signUpEmail];
    
    submitLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 380, 80, 30)];
    [submitLoginButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitLoginButton addTarget:self action:@selector(signUpMethod) forControlEvents: UIControlEventTouchUpInside];
    submitLoginButton.backgroundColor = [UIColor greenColor];
    submitLoginButton.layer.cornerRadius = 15;
    submitLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [submitLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signUpView addSubview:submitLoginButton];
    
    cancelLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 380, 80, 30)];
    [cancelLoginButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelLoginButton addTarget:self action:@selector(cancelSignUp) forControlEvents: UIControlEventTouchUpInside];
    cancelLoginButton.backgroundColor = [UIColor redColor];
    cancelLoginButton.layer.cornerRadius = 15;
    cancelLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [cancelLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signUpView addSubview:cancelLoginButton];
    
//    avatar = [[UIImageView alloc] initWithFrame:CGRectMake(120, 280, 60, 60)];
//    avatar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
//    avatar.image = [UIImage imageNamed:@"boss"];
//    avatar.contentMode = UIViewContentModeScaleAspectFit;
//    [signUpView addSubview:avatar];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen2)];
    [self.view addGestureRecognizer:tap2];

}

- (void)signUpMethod
{
    
    
    PFUser *user = [PFUser user];
    user.username = displayName.text;
    user.password = signUpPassword.text;
    user.email = signUpEmail.text;
    
    NSURL* avatarURL = [NSURL URLWithString:user[@"avatar"]];
    NSData* avatarData = [NSData dataWithContentsOfURL:avatarURL];
    avatar.image = [UIImage imageWithData:avatarData];
    
    user[@"avatar"] = avatar;

    
    UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    [activity setColor:[UIColor orangeColor]];
    activity.color = [UIColor orangeColor];
    activity.frame = CGRectMake(0, 300, self.view.frame.size.width, 50);
    
    [signUpView addSubview:activity];

    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            [signUpView removeFromSuperview];
            [self.view addSubview:loginForm];
        } else
        {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Sign Up Error" message:errorString delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            [alertView show];

        }
        [activity removeFromSuperview];
        [UIView animateWithDuration:0.2 animations:^{
            loginForm.frame = self.view.frame;
        }];

        
    }];

}

-(void)cancelSignUp
{
    [signUpView removeFromSuperview];
}

-(void)tapScreen
{
    [nameField resignFirstResponder];
    [password resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        loginForm.frame = self.view.frame;
    }];
}

-(void)tapScreen2
{
    [displayName resignFirstResponder];
    [signUpPassword resignFirstResponder];
    [signUpEmail resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        signUpView.frame = self.view.frame;
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
    PFUser * user = [PFUser currentUser];
    
    user.username = nameField.text;
    user.password = password.text;
    
    nameField.text = nil;
    password.text = nil;
    
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

    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        if (error == nil)
        {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
        }
        else
        {
            NSString * errorDescription = error.userInfo[@"error"];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorDescription delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            [alertView show];
            
            [activity removeFromSuperview];

        }

    }];
    
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
