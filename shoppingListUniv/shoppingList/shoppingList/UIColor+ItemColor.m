//
//  UIColor+ItemColor.m
//  shoppingList
//
//  Used to override the UIColor class with a extra method
//   which will check the itemName passed in and if it is one
//   of the listed names then the color is pased back to point of call
//  otherwise the color returned is black.
//
//  Created by Eddie Power on 17/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "UIColor+ItemColor.h"

@implementation UIColor (ItemColor)

+(UIColor*)colorForItem:(NSString*)itemName
{

    if([itemName isEqualToString:@"Apple"])
    {
        return [UIColor colorWithRed:119/255.0 green:195/255.0 blue:86/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Orange"])
    {
        return [UIColor colorWithRed:240/255.0 green:129/255.0 blue:58/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Cheese"])
    {
        return [UIColor colorWithRed:192/255.0 green:56/255.0 blue:45/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Banana"])
    {
        return [UIColor colorWithRed:105/255.0 green:150/255.0 blue:237/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Bread"])
    {
        return [UIColor colorWithRed:169/255.0 green:151/255.0 blue:238/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Nexus 10"])
    {
        return [UIColor colorWithRed:160/255.0 green:76/255.0 blue:158/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Macbook Air"])
    {
        return [UIColor colorWithRed:248/255.0 green:205/255.0 blue:65/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Milk"])
    {
        return [UIColor colorWithRed:224/255.0 green:190/255.0 blue:109/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"Nexus 5"])
    {
        return [UIColor colorWithRed:248/255.0 green:98/255.0 blue:137/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"iPad Air"])
    {
        return [UIColor colorWithRed:184/255.0 green:157/255.0 blue:64/255.0 alpha:1];
    }
    else if([itemName isEqualToString:@"iPhone 5S"])
    {
        return [UIColor colorWithRed:168/255.0 green:180/255.0 blue:48/255.0 alpha:1];
    }
    else
    {
        return [UIColor blackColor];
    }
}

@end
