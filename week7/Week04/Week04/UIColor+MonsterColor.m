//
//  UIColor+MonsterColor.m
//  Week04
//
//  Created by Eddie Power on 9/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "UIColor+MonsterColor.h"

@implementation UIColor (MonsterColor)

+(UIColor*)colorForType:(NSString*)type
{
    if([type isEqualToString:@"Normal"])
    {
        return [UIColor colorWithRed:168/255.0 green:166/255.0 blue:122/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Fire"])
    {
        return [UIColor colorWithRed:240/255.0 green:129/255.0 blue:58/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Fighting"])
    {
        return [UIColor colorWithRed:192/255.0 green:56/255.0 blue:45/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Water"])
    {
        return [UIColor colorWithRed:105/255.0 green:150/255.0 blue:237/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Flying"])
    {
        return [UIColor colorWithRed:169/255.0 green:151/255.0 blue:238/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Grass"])
    {
        return [UIColor colorWithRed:119/255.0 green:195/255.0 blue:86/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Poison"])
    {
        return [UIColor colorWithRed:160/255.0 green:76/255.0 blue:158/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Electric"])
    {
        return [UIColor colorWithRed:248/255.0 green:205/255.0 blue:65/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Ground"])
    {
        return [UIColor colorWithRed:224/255.0 green:190/255.0 blue:109/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Psychic"])
    {
        return [UIColor colorWithRed:248/255.0 green:98/255.0 blue:137/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Rock"])
    {
        return [UIColor colorWithRed:184/255.0 green:157/255.0 blue:64/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Ice"])
    {
        return [UIColor colorWithRed:152/255.0 green:215/255.0 blue:216/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Bug"])
    {
        return [UIColor colorWithRed:168/255.0 green:180/255.0 blue:48/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Dragon"])
    {
        return [UIColor colorWithRed:113/255.0 green:83/255.0 blue:245/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Ghost"])
    {
        return [UIColor colorWithRed:112/255.0 green:93/255.0 blue:150/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Dark"])
    {
        return [UIColor colorWithRed:112/255.0 green:88/255.0 blue:72/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Steel"])
    {
        return [UIColor colorWithRed:184/255.0 green:185/255.0 blue:207/255.0 alpha:1];
    }
    else if([type isEqualToString:@"Fairy"])
    {
        return [UIColor colorWithRed:238/255.0 green:157/255.0 blue:172/255.0 alpha:1];
    }
    else
    {
        return [UIColor blackColor];
    }
}
@end
