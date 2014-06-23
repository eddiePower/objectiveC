//////////////////////////////////////////////////////////////////////////
//  main.m                                                             //
//  shoppingListEMP                                                   //
//                                                                   //
//  Portfolio excorcise 1 for FIT3027 iOS/Android.                  //
//                                                                 //
//  Created by Eddie Power on 11/03/2014.                         //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "item.h"
#import "menuDriver.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        //--------Main code area----------
        //    Variable/object declorations
        //item* i1 = [[item alloc] initWithName:@"RedBull 2Ltr" itemDescription:@"Bottle of fake energy" itemPrice:4.95];
        //item* i2 = [[item alloc] init];
        //item* i3 = [[item alloc] initWithName:@"Apple" itemDescription:@"Nice 4 week old Fresh fruit" itemPrice:0.95];
        //item* i4 = [[item alloc] initWithName:@"TV Snacks" itemDescription:@"250g packet of chocolate biscuits" itemPrice:5.95];
        //item* i5 = [[item alloc] initWithName:@"Hot Chicken" itemDescription:@"Full sized cooked Roast chicken" itemPrice:14.95];
        
        
        //can take unlimited amount of items in array untill nil is passed signaling end of array.
        //doesnt need to have a type (not type safe) like items or string etc.
        //made as an array of id type.
        //NSArray* array = [NSArray arrayWithObjects:i1, i2, nil];
        //
        ////pulls out item at index 0 or first item.
        ////item * arrayItem = [array objectAtIndex:0];
        //
        ////itterate through array displaying description of all items stored
        //for (int i=0; i < [array count]; i++)
        //{
            //item* myItems = [array objectAtIndex:i];
            //NSLog(@"%@", myItems);
        //}
        //
        //NSMutableArray* mutableArray = [[NSMutableArray alloc] init];
        //[mutableArray addObject:i1];
        //[mutableArray addObject:i2];
        //
        ////remove object from mutableArray
        //[mutableArray removeObject:0];
        
        
        //get number from KB entry.
        //NSLog(@"\nPlease enter a number: ");
        //int number = [KeyboardScanner readIntFromKeyboard];
        //NSLog(@"\nNumber entered was %d", number);
        //
        ////this is the main list of items to choose from.
        //// shoppingList* allItems = [[shoppingList alloc] initWithItem: i1 secondItem: i2 thirdItem: i3 fourthItem: i4 andLastItem: i5];
        ////the users shopping list empty to begin with.
        //shoppingList* myList = [[shoppingList alloc] init];
        //
        ////Add items to empty list manually after plain init.
        //[myList addItem:i1];
        //[myList addItem:i2];
        //[myList addItem:i3];
        //[myList addItem:i4];
        //[myList addItem:i5];
        //
        //
        ////testing purposes can be removed or commented
        //shoppingList* mySecondList = [[shoppingList alloc] initWithItem: i1 secondItem: i2 thirdItem: i3 fourthItem: i4 andLastItem: i5];
        
        //should be called if menu item no. is pressed (i.e: number 1 pressed) for remove item and then item
        // number comes from another choice then pass this message to removeItem.
        //[itemList removeItem:i2];

        
        //NSLog(@"My First List done with plain init!!!!\n");
        //for (int i=0; i < [myList.itemList count]; i++)
        //{
            //item* myItems = [myList.itemList objectAtIndex:i];
            //NSLog(@"%@", myItems);
        //}
        //
        //
        //
        //NSLog(@"\n\n\nMy Second List done with initWithItem!!!!\n");
        //for (int i=0; i < [mySecondList.itemList count]; i++)
        //{
            //item* mySecondItems = [mySecondList.itemList objectAtIndex:i];
            //NSLog(@"%@", mySecondItems);
        //}
        //
        //NSLog(@"\n\nThe total cost of First list is: $%.02f" , [myList calcTotalCost: myList.itemList]);
        //NSLog(@"\n\n\nTHE SHOPPING LIST DESCRIPTION TEST!!!\n %@", myList.description);
        //
        //NSLog(@"\n\nThe total cost of Second list is: $%.02f" , [mySecondList calcTotalCost: mySecondList.itemList]);
        //NSLog(@"\n\n\nTHE SECOND SHOPPING LIST DESCRIPTION TEST!!!\n %@", mySecondList.description);
        //!!!!!END TEST LOGIC MAIN LOGIC AREA BELOW!!!!
        
        //MENU driver test run
        menuDriver* myMenu = [[menuDriver alloc] init];
        //NSLog(@"\n\nMENU DRIVER TEST RUN!!!!!\n");
        //[myMenu.shoppingList addItem:i1];
        //NSLog(@"\n\nNEW LIST COST. $%.02f", [myMenu.shoppingList calcTotalCost: myMenu.shoppingList.itemList]);
        [myMenu runListMaker];
    }
    return 0;
}

