//
//  SLFTableViewController.m
//  Selfy
//
//  Created by Austen Johnson on 4/21/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import <Parse/Parse.h>

#import "SLFTableViewController.h"
#import "SLFTableViewCell.h"
#import "SLFSelfyViewController.h"
#import "SLFNewNavigationController.h"

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController
{
    UIView * header;
    UILabel * titleHeader;
    UIButton * settingsButton;
    UIButton * addNewButton;
    NSArray *selfyList;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
        selfyList=  @[];
                
        
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;
        
        
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        header.backgroundColor  = [UIColor whiteColor];
        self.tableView.tableHeaderView = header;
        
        titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 40)];
        titleHeader.text = @"\u03a3" @"\u0395" @"\u039B" @"\u03A6" @"\u03A5";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [self.view addSubview:titleHeader];
        
    }
    return self;
}


-(void)settings
{
    //
}

-(void)openNewSelfy
{
    SLFSelfyViewController * moveView = [[SLFSelfyViewController alloc] initWithNibName:nil bundle:nil];
    
    SLFNewNavigationController * nc = [[SLFNewNavigationController alloc] initWithRootViewController:moveView];
    
    nc.navigationBar.barTintColor = [UIColor colorWithRed:0.137f green:0.627f blue:0.906f alpha:1.0];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    
    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openNewSelfy)];
    self.navigationItem.rightBarButtonItem = addNewSelfyButton;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshSelfies];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshSelfies
{
    // change order by created date: newest first - DONE
    
    // after user connected to selfy : filter only your users selfies
    
    PFQuery * query = [PFQuery queryWithClassName:@"UserSelfy"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"username" equalTo:@"ajohnson21"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        selfyList = objects;
        [self.tableView reloadData];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selfyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"]; //forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (cell == nil) cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.selfyInfo = selfyList[indexPath.row];
    
    return cell;
}

@end
