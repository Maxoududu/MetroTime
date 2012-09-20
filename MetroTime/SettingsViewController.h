//
//  SettingsViewController.h
//  MetroTime
//
//  Created by Maxime Dupuy on 19/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsTableViewController.h"

@class SettingsViewController;

@interface SettingsViewController : UIViewController

@property(strong, nonatomic) NSMutableArray *listeLinePref;

@property (weak, nonatomic) IBOutlet UITextField *lineNameTF;
@property (weak, nonatomic) IBOutlet UITextField *urlTF;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
