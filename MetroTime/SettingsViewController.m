//
//  SettingsViewController.m
//  MetroTime
//
//  Created by Maxime Dupuy on 19/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize lineNameTF;
@synthesize urlTF;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLineNameTF:nil];
    [self setUrlTF:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)save:(id)sender {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    // Hide the keyboard
    [lineNameTF resignFirstResponder];
    [urlTF resignFirstResponder];
    
    //Get values of textfields
    NSString *lineName = [lineNameTF text];
    NSString *url = [urlTF text];
    NSString *separator =@"§";
    NSString *data = [lineName stringByAppendingString:[separator stringByAppendingString:url]];
    
    self.listeLinePref = [preferences objectForKey:@"listLine"];
    [self.listeLinePref addObject:data];
    
    // Save Values
    [preferences setObject:self.listeLinePref forKey:@"listLine"];
    [preferences synchronize];
    NSLog(@"adding prefs");
    [self dismissModalViewControllerAnimated:true];
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:true];
}


@end
