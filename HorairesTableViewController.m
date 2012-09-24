//
//  HorairesTableViewController.m
//  MetroTime
//
//  Created by Maxime Dupuy on 18/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import "HorairesTableViewController.h"
#import "RatpTimeStealer.h"
#import "horaire.h"

@interface HorairesTableViewController ()

@end

@implementation HorairesTableViewController

// private method to get line stored into the Prefs data
- (void)getData
{
    
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listLine = [[NSMutableArray alloc] initWithCapacity:0];
    
    // Create default preferences if none exist (Olympiade line 14)
    if ([pref objectForKey:@"listLine"]== nil) {
        
        NSString *line=@"Olympiade M14";
        NSString *url=@"http://wap.ratp.fr/siv/schedule?service=next&reseau=metro&referer=station&lineid=M14&directionsens=A&stationname=oly&submitAction=Valider";
        // we use a separator because custom object can't be saved into NSUserDefaults
        NSString *separator =@"§";
        
        NSString *data = [line stringByAppendingString:[separator stringByAppendingString:url]];
        NSLog(@"String par défault %@",data);
        
        [listLine addObject:data];
        
        //saving the default line
        [[NSUserDefaults standardUserDefaults] setObject:listLine forKey:@"listLine"];
        NSLog(@"List par défault générer");
    }
    
    //Reading the preferences file which contain lines informations (name & URL)
    
    listLine = [NSMutableArray arrayWithArray:[pref objectForKey:@"listLine"]];
    
    self.listeHoraires = [RatpTimeStealer getAllTimes:listLine];

}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    //[self getData];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.listeHoraires = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.listeHoraires.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{      
    // creating the custom cell 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"horaireCell"];
    Horaire *h = [self.listeHoraires objectAtIndex:indexPath.row];
    
	UILabel *nameLineLabel = (UILabel *)[cell viewWithTag:1];
	nameLineLabel.text = h.line;
    UILabel *dirLabel = (UILabel *)[cell viewWithTag:2];
	dirLabel.text = h.direction;
	UILabel *timeLabel = (UILabel *)[cell viewWithTag:3];
	timeLabel.text = h.timeLeft;
    return cell;

}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
// refresh the view (calling the model) when appear
- (void) viewDidAppear:(BOOL)animated{
    [self getData];
    [self.tableView reloadData];
    NSLog(@"HoraireTableviewAppear");
}

// action for the refresh button
- (IBAction)refresh:(id)sender {
     NSLog(@"Refresh pressed");
    [self getData];
    [self.tableView reloadData];
}
@end
