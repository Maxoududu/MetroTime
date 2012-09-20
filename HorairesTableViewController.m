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
    
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    NSMutableArray *listLine = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    // Create default preference if none
    if ([pref objectForKey:@"listLine"]== nil) {
        
        NSString *line=@"Olympiade Ligne 14";
        NSString *url=@"http://wap.ratp.fr/siv/schedule?service=next&reseau=metro&referer=station&lineid=M14&directionsens=A&stationname=oly&submitAction=Valider";
        NSString *separator =@"§";
        
        NSString *data = [line stringByAppendingString:[separator stringByAppendingString:url]];
        NSLog(@"String par défault %@",data);
        
        [listLine addObject:data];
        
        //saving the default line 
        [[NSUserDefaults standardUserDefaults] setObject:listLine forKey:@"listLine"];
        NSLog(@"List par défault générer");
    }
        
    //on récupère la liste des ligne enregistré 

    listLine = [NSMutableArray arrayWithArray:[pref objectForKey:@"listLine"]];
    
    self.listeHoraires = [RatpTimeStealer getAllTimes:listLine];
    
    [super viewDidLoad];
    

    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    Horaire *h = [self.listeHoraires objectAtIndex:indexPath.row];
        
    cell.textLabel.text = [h.line stringByAppendingString:h.direction];
    cell.detailTextLabel.text = h.timeLeft;
    
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


- (IBAction)refresh:(id)sender {
     NSLog(@"Refresh pressed");
    
    
    [self.tableView reloadData];
    
}
@end
