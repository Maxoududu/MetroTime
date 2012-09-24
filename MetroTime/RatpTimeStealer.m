//
//  RatpTimeStealer.m
//  MetroTime
//
//  Created by Maxime Dupuy on 18/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import "RatpTimeStealer.h"
#import "Horaire.h"


@implementation RatpTimeStealer

// Public method that parse the RATP website and return a mutable Array of "horaire" object
+ (NSMutableArray *)readRATPTime:(NSURL *)url:(NSString *)line
{
    // Read the source code of the webpage
    NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"Source : %@ \n\n",source);
    
    NSString *garbage;
    NSString *direction;
    NSString *timeLeft;
    
    NSScanner *aScanner = [NSScanner scannerWithString:source];
    
    NSMutableArray *listeHoraires = [[NSMutableArray alloc] initWithCapacity:0];
    
    // The scanner search for specific separator in the source
    
    while ([aScanner isAtEnd] == NO)
    {
        //creation of a custom object
        Horaire *horaire = [[Horaire alloc]init];
        
        
        [aScanner scanUpToString:@"&gt;&nbsp;" intoString:&garbage];
        [aScanner scanUpToString:@"</td></tr>" intoString:&direction];
        if(direction != nil)direction = [direction substringFromIndex:10]; // deleting unusefull char
        [aScanner scanUpToString:@"<b>" intoString:&garbage];
        [aScanner scanUpToString:@"</b></td>" intoString:&timeLeft];
        if(timeLeft != nil)timeLeft = [timeLeft substringFromIndex:3]; // deleting unusefull char
        
        NSLog(@"\n dir : %@ timeleft : %@",direction,timeLeft);
        // Saving variables into the object
        horaire.direction = direction;
        horaire.line = line;
        horaire.timeLeft = timeLeft;
        
        //add the object into a mutable Array (only if time information exist)
        if (timeLeft != nil)[listeHoraires addObject:horaire];
        
        //clearing variables
        garbage = nil;
        direction = nil;
        timeLeft = nil;
    }
    
    NSLog(@"Array : %@",listeHoraires);
    
    return listeHoraires;
}

// public method that handle multiple line and return all the data into 1 mutable array
+ (NSMutableArray *)getAllTimes:(NSMutableArray *)listline
{
    NSMutableArray *listAlltime = [[NSMutableArray alloc] initWithCapacity:0];

    NSInteger counter = listline.count;
    NSLog(@"compteur %i",counter);
    
    while (counter > 0) {
        NSString *datastored = [listline objectAtIndex:counter-1];
        NSScanner *aScanner = [NSScanner scannerWithString:datastored];
        NSString *lineName;
        NSString *url;
        // read the prefs data send by the controller and cut the string (we cannot save custom object into NSUserDefaults)
        [aScanner scanUpToString:@"§" intoString:&lineName];
        url = [datastored substringFromIndex:lineName.length+1];
        // call the parser with the correct entries and add the given array to the array containing all the data
        [listAlltime addObjectsFromArray:[self readRATPTime:[NSURL URLWithString:url] :lineName]];
        
        counter--;
        
    }
    
    NSLog(@"listalltime %@",listAlltime);

    return listAlltime;
    
}


@end
