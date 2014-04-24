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

@interface SLFTableViewController () 

@end

@implementation SLFTableViewController
{
    UIView * header;
    UILabel * titleHeader;
    UIButton * settingsButton;
    UIButton * addNewButton;
    NSMutableArray *selfyList;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
        selfyList=  [@[
                              @{
                                @"selfImage":@"http://www.cwu.edu/~helmersk/pirateimage.jpg",
                                @"caption":@"It's a ship!",
                                @"userID":@"ajohnson21",
                                @"avatar":@"http://www.clipartbest.com/cliparts/pi5/6ap/pi56apLiB.jpeg",
                                @"selfyID":@""
                                 
                                }
                              
                              ] mutableCopy];
        
        
        
        
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;

        
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        header.backgroundColor  = [UIColor whiteColor];
        self.tableView.tableHeaderView = header;
        
        titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 320, 90)];
        titleHeader.text = @"\u03a3" @"\u0395" @"\u039B" @"\u03A6" @"\u03A5";
        titleHeader.textColor = [UIColor blackColor];
        titleHeader.font = [UIFont fontWithName:@"HoeflerText-Italic" size:30];
        [self.view addSubview:titleHeader];
        
//        settingsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
//        [settingsButton setFrame:CGRectMake(20, 25, 60, 20)];
        settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, 60, 20)];
        [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
        [settingsButton addTarget:self action:@selector(settings) forControlEvents: UIControlEventTouchUpInside];
        settingsButton.backgroundColor = [UIColor blackColor];
        settingsButton.layer.cornerRadius = 6;
        settingsButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:settingsButton];
        
        addNewButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addNewButton  setFrame:CGRectMake(280, 25, 20, 20)];
        [addNewButton setTitle:@"Add New" forState:UIControlStateNormal];
        [addNewButton addTarget:self action:@selector(addNew) forControlEvents: UIControlEventTouchUpInside];
        addNewButton.backgroundColor = [UIColor blackColor];
        addNewButton.layer.cornerRadius = 6;
        addNewButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [addNewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:addNewButton];
    }
    return self;
}


-(void)settings
{
    //
}

-(void)addNew
{
    //
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"ooooh numRows returning %d", (int)[selfyList count]);
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
