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


+ (NSMutableArray *)readRATPTime:(NSURL *)url:(NSString *)line
{
    
    NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"Source : %@ \n\n",source);
    
    NSString *garbage;
    NSString *direction;
    NSString *timeLeft;
    
    NSScanner *aScanner = [NSScanner scannerWithString:source];
    
    NSMutableArray *listeHoraires = [[NSMutableArray alloc] initWithCapacity:0];
    
    
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
        if (direction != NULL) horaire.direction = direction;
        if (direction != NULL) horaire.line = line;
        if (horaire != NULL) horaire.timeLeft = timeLeft;
        
        [listeHoraires addObject:horaire];
        
        direction = nil;
        timeLeft = nil;
    }
    
    NSLog(@"Array : %@",listeHoraires);
    
    return listeHoraires;
}

+ (NSMutableArray *)getAllTimes:(NSMutableArray *)listline
{
    NSMutableArray *listAlltime = [[NSMutableArray alloc] initWithCapacity:0];

    NSInteger compteur = listline.count;
    NSLog(@"compteur %i",compteur);
    
    while (compteur  > 0) {
        NSString *datastored = [listline objectAtIndex:compteur-1];
        NSScanner *aScanner = [NSScanner scannerWithString:datastored];
        NSString *lineName;
        NSString *url;
        [aScanner scanUpToString:@"§" intoString:&lineName];
        url = [datastored substringFromIndex:lineName.length+1];
        
        [listAlltime addObjectsFromArray:[self readRATPTime:[NSURL URLWithString:url] :lineName]];

        
        compteur--;
        
    }
    
    NSLog(@"listalltime %@",listAlltime);

    return listAlltime;
    
}


@end
