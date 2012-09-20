//
//  RatpTimeStealer.h
//  MetroTime
//
//  Created by Maxime Dupuy on 18/09/12.
//  Copyright (c) 2012 Maxime Dupuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatpTimeStealer : NSObject

+ (NSMutableArray *)readRATPTime:(NSURL *)url:(NSString *)line;
+ (NSMutableArray *)getAllTimes:(NSMutableArray *)listline;


@end
