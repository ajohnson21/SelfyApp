//
//  SLFSignUpViewController.m
//  Selfy
//
//  Created by Austen Johnson on 4/29/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFSignUpViewController.h"
#import "SLFTableViewController.h"
#import <Parse/Parse.h>

@interface SLFSignUpViewController () <UITextFieldDelegate>

@end

@implementation SLFSignUpViewController
{
    UIView * signUpForm;
    NSArray * fieldNames;
    NSMutableArray * fields;
    
    float signupOrigY;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor whiteColor];
                
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem * cancelSignUpButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSignup)];
    
    cancelSignUpButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSignUpButton;
    
    signupOrigY = (self.view.frame.size.height - 240) /2;
    signUpForm = [[UIView alloc] initWithFrame:CGRectMake(20, signupOrigY, 280, 240)];
    
    [self.view addSubview:signUpForm];
    
    
    fieldNames = @[
               @"Username",
               @"Password",
               @"Display Name",
               @"Email"
               ];
    
    fields = [@[] mutableCopy];
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, index * 50, 280, 40)];
        textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        textField.layer.cornerRadius = 6;
        textField.placeholder = name;
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.delegate = self;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [fields addObject:textField];
        [signUpForm addSubview:textField];

        
        
    }
    
    UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, [fieldNames count] * 50, 280, 40)];
    [submitButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(signUp) forControlEvents: UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor greenColor];
    submitButton.layer.cornerRadius = 6;
    [signUpForm addSubview:submitButton];
    
    UITapGestureRecognizer * hideKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hideKeyboard];
    
}

-(void)signUp
{
    
    
    PFUser * user = [PFUser user];
    
    UIImage * avatarImage = [UIImage imageNamed:@"boss"];
    
    NSData * imageData = UIImagePNGRepresentation(avatarImage);
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data:imageData];
    
    user.username = ((UITextField *)fields[0]).text;
    user.password = ((UITextField *)fields[1]).text;
    user.email = ((UITextField *)fields[3]).text;
    user[@"displayName"] = ((UITextField *)fields[2]).text;
    user[@"avatar"] = imageFile;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
        {
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            
            pnc.navigationController.navigationBarHidden = NO;
            pnc.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
            [self cancelSignup];
        } else {
            NSString * errorDescription = error.userInfo[@"error"];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];
            [alertView show];

        }
    }];
}

-(void)cancelSignup
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    NSInteger index = [fields indexOfObject:textField];
//    
//   int extraSlide = index * 25 + 65;
//    NSLog(@"%.00f", self.view.frame.size.height);
    
    // 504 h for 4"
    // 416 h for 3.5"
    
    int extraSlide = 0;
    
    if(self.view.frame.size.height > 500)
    {
    extraSlide = 107;
    } else
    {
        NSInteger index = [fields indexOfObject:textField];
        
        extraSlide = index * 25 + 65;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        signUpForm.frame = CGRectMake(20, signupOrigY - extraSlide, 280, 240);
        
        
    }];
}

//-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSInteger index = [fields indexOfObject:textField];
//    NSInteger emptyIndex = [fields count];
//    for (UITextField * textFieldItem in fields)
//    {
//        NSInteger fieldIndex = [fields indexOfObject:textFieldItem];
//        
//            if(emptyIndex == [fields count])
//            {
//                if([textFieldItem.text isEqualToString:@""])
//                {
//                    emptyIndex = fieldIndex;
//                }
//            }
//    }
//    
//    if (index <= 0) return YES;
//    return NO;
//    
//}

-(void)hideKeyBoard
{
    for (UITextField * textFieldItem in fields) {
        [textFieldItem resignFirstResponder];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        signUpForm.frame = CGRectMake(20, signupOrigY, 280, 240);
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
