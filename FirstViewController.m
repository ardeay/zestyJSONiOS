//
//  FirstViewController.m
//  zestyJSONiOS
//
//  Created by Randy Apuzzo on 8/4/15.
//  Copyright (c) 2015 Zesty.io Platform, Inc. All rights reserved.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@property (nonatomic, strong) NSArray *arrZnodes;

@property (nonatomic, strong) NSDictionary *znodeDetailsDictionary;

@property (nonatomic, strong) NSDictionary *znodeIndividualDetailsDictionary;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
-(void)getZestyData;

@end

@implementation FirstViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Make self the delegate of the textfield.
    self.txtCountry.delegate = self;
    
    // Make self the delegate and datasource of the table view.
    self.tblZnodeDetails.delegate = self;
    self.tblZnodeDetails.dataSource = self;
    
    // Initially hide the table view.
    self.tblZnodeDetails.hidden = YES;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tblZnodeDetails addSubview:self.refreshControl];
    
    
    [self getZestyData];
}
- (void)refresh:(id)sender
{
    // do your refresh here and reload the tablview
    [self getZestyData];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

-(void)getZestyData{
    // Prepare the URL that we'll get the country info data from.
    NSString *URLString = [NSString stringWithFormat:@"http://cc2bcf99770b0d13a9cc12deaf1749fd.rapuzzo.dr.gozesty.com/z/content/%d.json", 529];
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
                
                //self.znodeDetailsDictionary = [[returnedDict objectForKey:@"data"] objectAtIndex:0];
                self.znodeDetailsDictionary = returnedDict;
                //NSLog(@"%@", self.znodeDetailsDictionary);
                //self.lblTitle.text = [NSString stringWithFormat:@"%@ (Published %@)", [self.znodeDetailsDictionary objectForKey:@"title"], [self.znodeDetailsDictionary objectForKey:@"date"]];
                
                [self.tblZnodeDetails reloadData];
                
                // Show the table view.
                self.tblZnodeDetails.hidden = NO;
                
                [self.refreshControl endRefreshing];
            }
            
        }
    }];
    
    
}



#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    // Find the index of the typed country in the arrZnodes array.
    NSInteger index = -1;
    for (NSUInteger i=0; i<self.arrZnodes.count; i++) {
        NSString *currentCountry = [self.arrZnodes objectAtIndex:i];
        if ([currentCountry rangeOfString:self.txtCountry.text.uppercaseString].location != NSNotFound) {
            index = i;
            break;
        }
    }
    
    // Check if the given country was found.
    if (index != -1) {
        
        [self getZestyData];
    }
    else{
        // If the country was not found then show an alert view displaying a relevant message.
        [[[UIAlertView alloc] initWithTitle:@"Search Empty" message:@"No articles match your search." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
    }
    
    // Hide the keyboard.
    [self.txtCountry resignFirstResponder];
    
    return YES;
}


#pragma mark - UITableView method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
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
    
    cell.detailTextLabel.text = @"Download";
    cell.textLabel.text = [self.znodeIndividualDetailsDictionary objectForKey:@"title"];
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma mark - IBAction method implementation

- (IBAction)sendJSON:(id)sender {
    
}


@end
