//
//  Monster.h
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Monster : NSObject

@property (strong, nonatomic) NSString* name;
@property (nonatomic) int attackPower;
@property (strong, nonatomic) NSString* type;

-(id)initWithName:(NSString*)name attackPower:(int)attackPower andType:(NSString*)type;

@end
