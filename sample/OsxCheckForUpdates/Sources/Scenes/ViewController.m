//
//  ViewController.m
//  OsxCheckForUpdates
//
//  Created by Hung Truong on 5/6/19.
//  Copyright © 2019 Hung Truong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSDictionary *appInfoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVer = [appInfoDict objectForKey:@"CFBundleVersion"];
    self.appVersionLabel.stringValue = [NSString stringWithFormat:@"App Version: %@", appVer];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
