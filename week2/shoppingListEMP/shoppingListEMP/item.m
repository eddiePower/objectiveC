//////////////////////////////////////////////////////////////////////////
//  item.m                                                             //
//  shoppingListEMP                                                   //
//                                                                   //
//  Portfolio excorcise 1 for FIT3027 iOS/Android.                  //
//                                                                 //
//  Created by Eddie Power on 11/03/2014.                         //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import "item.h"

@implementation item

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Default Item";
        self.itemDescription = @"A default item description";
        self.price = 20.00;
    }
    return self;
}


//Initialisation method (Constructor in other languages) with parameters passed in.
-(id)initWithName:(NSString *)name itemDescription:(NSString *)aDescription itemPrice:(double)price
{
    if (self = [super init])
    {
        self.name = name;
        self.itemDescription = aDescription;
        self.price = price;
    }
    return self;
}

//override the default description method to structure it in a more readable form.
-(NSString *)description
{
    return [NSString stringWithFormat:@"Item Name: %@ Description: %@ Price: $%.02f", self.name, self.itemDescription, self.price];
}

@end
