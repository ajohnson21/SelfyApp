//
//  SLFAppDelegate.m
//  Selfy
//
//  Created by Austen Johnson on 4/21/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <Parse/Parse.h>

#import "SLFAppDelegate.h"
#import "SLFTableViewController.h"
#import "SLFLoginViewController.h"
#import "SLFSelfyViewController.h"

@implementation SLFAppDelegate
{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    TIY app key
//    [Parse setApplicationId:@"H1JHLiA7kFRmIWvtbkHDcnA1Caj4UofHxRx6UZAB"
//                  clientKey:@"dKLyXccYHUy1MXNgrdR2Sq5b1fNQoTr4clSXVd3p"];
    
    // my app key
    [Parse setApplicationId:@"H4E8ToZowFhb45QHqyvCYaW7MdE2KuywU87WdX26"
                  clientKey:@"WaMrS9njQsMETmnTQodORv41w2n8I7poxZIAQn7d"];
    
//    self.window.rootViewController = [[SLFSelfyViewController alloc] initWithNibName:nil bundle:nil];
    
    [PFUser enableAutomaticUser];
    
    UINavigationController * nav;
    
    PFUser * user = [PFUser currentUser];
    
    NSString * username = user.username;
    
    username = nil;
    
    if (username == nil)
    {
        nav = [[UINavigationController alloc] initWithRootViewController:[[SLFLoginViewController alloc] initWithNibName:nil bundle:nil]];
        nav.navigationBarHidden = YES;

    }
    else
    {
        nav = [[UINavigationController alloc] initWithRootViewController:[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
    }
    
    
    self.window.rootViewController = nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
