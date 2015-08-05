//
//  ZestyTableViewController.m
//  zestyJSONiOS
//
//  Created by Randy Apuzzo on 8/4/15.
//  Copyright (c) 2015 Zesty.io Platform, Inc. All rights reserved.
//

#import "ZestyTableViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "ZnodeViewController.h"

@interface ZestyTableViewController ()

@property (nonatomic, strong) NSArray *arrZnodes;

@property (nonatomic, strong) NSDictionary *znodeDetailsDictionary;

@property (nonatomic, strong) NSDictionary *znodeIndividualDetailsDictionary;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
-(void)getZestyData;

@end

@implementation ZestyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tblZnodeDetails addSubview:self.refreshControl];
   
    
    [self getZestyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(id)sender
{
    // do your refresh here and reload the tablview
    [self getZestyData];
    
   
    
}

#pragma mark - Zesty call
-(void)getZestyData{
    // Prepare the URL that we'll get the country info data from.
    NSString *URLString = [NSString stringWithFormat:@"%@", zestyJSONFeed];
    NSURL *url = [NSURL URLWithString:URLString];
    
    [AppDelegate downloadDataFromURL:url withCompletionHandler:^(NSData *data) {
        // Check if any data returned.
        if (data != nil) {
            NSError *error;
            NSMutableDictionary *returnedDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else{
                
                self.znodeDetailsDictionary = returnedDict;
                
                [self.tblZnodeDetails reloadData];
                
                // Show the table view.
                self.tblZnodeDetails.hidden = NO;
                 [self.refreshControl endRefreshing];
            }
            
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"open"]){
        
      
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    ZnodeViewController *znodeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"znodeView"];
    
   
    
    self.znodeIndividualDetailsDictionary = [[self.znodeDetailsDictionary objectForKey:@"data"] objectAtIndex:indexPath.row];
    
    //NSLog(@"%@", [self.znodeIndividualDetailsDictionary objectForKey:@"zid"]);
    
    znodeViewController.znode = [self.znodeIndividualDetailsDictionary objectForKey:@"zid"];
    
    
    //[self performSegueWithIdentifier:@"open" sender:znodeViewController];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:znodeViewController animated:YES];

    
}




#pragma mark - UITableView method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.znodeIndividualDetailsDictionary = [[self.znodeDetailsDictionary objectForKey:@"data"] objectAtIndex:indexPath.row];
    
    
    //NSLog(@"%@", self.znodeIndividualDetailsDictionary);
    
    cell.detailTextLabel.text = [self.znodeIndividualDetailsDictionary objectForKey:@"date"];
    cell.textLabel.text = [self.znodeIndividualDetailsDictionary objectForKey:@"title"];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}


- (IBAction)sendJSON:(id)sender{
    
    
}
    
@end
