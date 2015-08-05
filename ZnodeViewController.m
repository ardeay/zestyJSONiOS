//
//  ZnodeViewController.m
//  zestyJSONiOS
//
//  Created by Randy Apuzzo on 8/4/15.
//  Copyright (c) 2015 Zesty.io Platform, Inc. All rights reserved.
//

#import "ZnodeViewController.h"
#import "AppDelegate.h"

@interface ZnodeViewController ()


@property (nonatomic, strong) NSDictionary *znodeData;

-(void)getZestyData;

@end

@implementation ZnodeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getZestyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Zesty call
-(void)getZestyData{
    // Prepare the URL that we'll get the country info data from.
      NSLog(@"%@", self.znode);
    
    NSString *URLString = [NSString stringWithFormat:@"http://65ec6eae61762ba5dfd36c8ff8ae0272.rapuzzo.dr.gozesty.com/z/content/%@.json", self.znode];
    NSLog(@"%@", URLString);
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
               // NSLog(@"%@", returnedDict);
                
                self.znodeData = [returnedDict objectForKey:@"data"];
               
                
                self.lblTitle.text = [NSString stringWithFormat:@"%@ (Published %@)", [self.znodeData  objectForKey:@"title"], [self.znodeData objectForKey:@"date"]];
                
                [self.htmlContent loadHTMLString:[NSString stringWithFormat:@"%@", [self.znodeData  objectForKey:@"article_body"]] baseURL:nil];
                
            }
            
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
