//
//  HorairesTableViewController.h
//  MetroTime
//
//  Created by Maxime Dupuy on 18/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorairesTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *listeHoraires;

- (void)getData;
- (IBAction)refresh:(id)sender;

@end
