//
//  Monster.m
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import "Monster.h"

@implementation Monster

-(id)initWithName:(NSString *)name attackPower:(int)attackPower andType:(NSString *)type
{
    if(self = [super init])
    {
        self.name = name;
        self.attackPower = attackPower;
        self.type = type;
    }
    return self;
}

@end
