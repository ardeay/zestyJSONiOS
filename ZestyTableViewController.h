//
//  ZestyTableViewController.h
//  zestyJSONiOS
//
//  Created by Randy Apuzzo on 8/4/15.
//  Copyright (c) 2015 Zesty.io Platform, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZestyTableViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblZnodeDetails;

- (IBAction)sendJSON:(id)sender;


@end
