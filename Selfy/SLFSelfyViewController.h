//
//  SLFSelfyViewController.h
//  Selfy
//
//  Created by Austen Johnson on 4/22/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SLFSelfyViewController : UIViewController <UITableViewDelegate>
{
    NSArray * imageArray;
}

@property (nonatomic) IBOutlet UITableView * imageTable;

@end





