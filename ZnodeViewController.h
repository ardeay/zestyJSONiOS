//
//  ZnodeViewController.h
//  zestyJSONiOS
//
//  Created by Randy Apuzzo on 8/4/15.
//  Copyright (c) 2015 Zesty.io Platform, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZnodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIScrollView *content;


@property (weak,nonatomic) IBOutlet NSString *znode;

@property (weak, nonatomic) IBOutlet UIWebView *htmlContent;



@end
