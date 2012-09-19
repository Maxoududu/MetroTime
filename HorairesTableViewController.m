//
//  HorairesTableViewController.m
//  MetroTime
//
//  Created by Maxime Dupuy on 18/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import "HorairesTableViewController.h"
#import "Horaire.h"

@interface HorairesTableViewController ()

@end

@implementation HorairesTableViewController


- (void)extractHoraireFromURL:(NSURL *)url
{
    
    NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"Source : %@ \n\n",source);
    
    NSString *garbage;
    NSString *direction;
    NSString *timeLeft;
    
    NSScanner *aScanner = [NSScanner scannerWithString:source];
    
    self.listeHoraires = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    
    while ([aScanner isAtEnd] == NO)
    {
        
        Horaire *horaire = [[Horaire alloc]init];
        
        
        [aScanner scanUpToString:@"&gt;&nbsp;" intoString:&garbage];
        [aScanner scanUpToString:@"</td></tr>" intoString:&direction];
        if(direction != nil)direction = [direction substringFromIndex:10];
        [aScanner scanUpToString:@"<b>" intoString:&garbage];
        [aScanner scanUpToString:@"</b></td>" intoString:&timeLeft];
        if(timeLeft != nil)timeLeft = [timeLeft substringFromIndex:3];
        
        NSLog(@"\n dir : %@ timeleft : %@",direction,timeLeft);
        if (direction != nil) horaire.direction = direction;
        if (direction != nil) horaire.line = @"Ligne 14 ";
        
        if (horaire != nil) horaire.timeLeft = timeLeft;
        
        [self.listeHoraires addObject:horaire];
        
        direction = nil;
        timeLeft = nil;
    }
    
    NSLog(@"Array : %@",self.listeHoraires);
    
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
    [super viewDidLoad];
    
    [self extractHoraireFromURL:[NSURL URLWithString:@"http://wap.ratp.fr/siv/schedule?service=next&reseau=metro&referer=station&lineid=M14&directionsens=A&stationname=oly&submitAction=Valider"]];

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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        Horaire *h = [self.listeHoraires objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [h.line stringByAppendingString:h.direction];
        cell.detailTextLabel.text = h.timeLeft;
    }
    
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


@end
