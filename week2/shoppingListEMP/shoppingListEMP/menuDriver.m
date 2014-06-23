//////////////////////////////////////////////////////////////////////////
//  menuDriver.m                                                       //
//  ShoppingListEMP                                                   //
//                                                                   //
// Portfolio excorcise 1 for FIT3027 iOS/Android.                   //
//                                                                 //
//  Created by Eddie Power on 18/3/14.                            //
//  Copyright (c) 2014 Eddie Power.                              //
//  All rights reserved.                                        //
/////////////////////////////////////////////////////////////////

#import "menuDriver.h"

@implementation menuDriver

-(id)init
{
    if (self = [super init])
    {
      item* i1 = [[item alloc] initWithName:@"RedBull 2Ltr" itemDescription:@"Bottle of fake energy" itemPrice:4.95];
      item* i2 = [[item alloc] init];
      item* i3 = [[item alloc] initWithName:@"Apple" itemDescription:@"Nice 4 week old Fresh fruit" itemPrice:0.95];
      item* i4 = [[item alloc] initWithName:@"TV Snacks" itemDescription:@"250g packet of chocolate biscuits" itemPrice:5.95];
      item* i5 = [[item alloc] initWithName:@"Hot Chicken" itemDescription:@"Full sized cooked Roast chicken" itemPrice:14.95];
    
      self.shoppingList = [[shoppingList alloc] init];
      self.allItemList = [[shoppingList alloc] initWithItem:i1 secondItem:i2 thirdItem:i3 fourthItem:i4 andLastItem:i5];
    }
    
    return self;
}

-(id)initWithItems1:(item*)i1 item2:(item*)i2 item3:(item*)i3 item4:(item*)i4 andItem5:(item*)i5
{
    if (self = [super init])
    {
        self.shoppingList = [[shoppingList alloc] init];
        self.allItemList = [[shoppingList alloc] initWithItem:i1 secondItem:i2 thirdItem:i3 fourthItem:i4 andLastItem:i5];
    }
    
    return self;
}

-(void)runListMaker
{
    int userChoice = 0;
    
    do
    {
      NSLog(@"Welcome to the shopping List creator app.\n\n");
      NSLog(@"******************Main Menu******************\n");
      NSLog(@"1. Show All Items to Choose from.\n");
      NSLog(@"2. Add item to your shopping list.\n");
      NSLog(@"3. Remove item from your shopping list.\n");
      NSLog(@"4. Show Shopping List Currently.");
      NSLog(@"5. Quit the Program.\n\n");
      NSLog(@"Please Enter your choice(1-5): ");
      
      userChoice = [KeyboardScanner readIntFromKeyboard];
        
      if (userChoice == 1)
      {
          NSLog(@"\nItems\n");
          NSLog(@"All Item's to choose from\n\n");
          
          for (int i=0; i < [self.allItemList.itemList count]; i++)
          {
             item* myItems = [self.allItemList.itemList objectAtIndex:i];
             NSLog(@"%d) %@", (i+1), myItems);
          }
      }
      else if (userChoice == 2)
      {
          NSLog(@"\nADD ITEM TO LIST\n\n");
          NSLog(@"All Item's to choose from\n\n");
          
          for (int i=0; i < [self.allItemList.itemList count]; i++)
          {
              item* myItems = [self.allItemList.itemList objectAtIndex:i];
              NSLog(@"%d) %@", (i+1), myItems);
          }
          
          NSLog(@"\nPlease Choose the number item to pick: ");
          userChoice = [KeyboardScanner readIntFromKeyboard];
          
          if (userChoice == 1)
          {
              [self.shoppingList.itemList addObject:([self.allItemList.itemList objectAtIndex:(userChoice - 1)])];
              
              NSLog(@"\n\n\n*********************ITEM 1 ADDED TO SHOP LIST**********************\n");
              for (int i=0; i < [self.shoppingList.itemList count]; i++)
              {
                  item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                  NSLog(@"%d) %@", (i+1), myItems);
              }
              
          }
          else if (userChoice == 2)
          {
              [self.shoppingList.itemList addObject:([self.allItemList.itemList objectAtIndex:(userChoice - 1)])];
              
              NSLog(@"\n\n\n*********************ITEM 2 ADDED TO SHOP LIST**********************\n");
              for (int i=0; i < [self.shoppingList.itemList count]; i++)
              {
                  item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                  NSLog(@"%d) %@", (i+1), myItems);
              }
          }
          else if (userChoice == 3)
          {
              [self.shoppingList.itemList addObject:([self.allItemList.itemList objectAtIndex:(userChoice - 1)])];
              
              NSLog(@"\n\n\n*********************ITEM 3 ADDED TO SHOP LIST**********************\n");
              for (int i=0; i < [self.shoppingList.itemList count]; i++)
              {
                  item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                  NSLog(@"%d) %@", (i+1), myItems);
              }
          }
          else if (userChoice == 4)
          {
              [self.shoppingList.itemList addObject:([self.allItemList.itemList objectAtIndex:(userChoice - 1)])];
              
              NSLog(@"\n\n\n*********************ITEM 4 ADDED TO SHOP LIST**********************\n");
              for (int i=0; i < [self.shoppingList.itemList count]; i++)
              {
                  item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                  NSLog(@"%d) %@", (i+1), myItems);
              }
          }
          else if (userChoice == 5)
          {
              [self.shoppingList.itemList addObject:([self.allItemList.itemList objectAtIndex:(userChoice - 1)])];
              
              NSLog(@"\n\n\n*********************ITEM 5 ADDED TO SHOP LIST**********************\n");
              for (int i=0; i < [self.shoppingList.itemList count]; i++)
              {
                  item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                  NSLog(@"%d) %@", (i+1), myItems);
              }
              userChoice = 1;
          }
          
      }
      else if (userChoice == 3)
      {
          NSLog(@"\nRemove Item from shopping list Page\n");
          NSLog(@"Item's currently on ShoppingList:\n\n");
          
          for (int i=0; i < [self.shoppingList.itemList count]; i++)
          {
              item* myItems = [self.shoppingList.itemList objectAtIndex:i];
              NSLog(@"%d) %@", (i+1), myItems);
          }
          
          NSLog(@"\nPlease Choose the number item to pick: ");
          userChoice = [KeyboardScanner readIntFromKeyboard];
          
          
             if (userChoice == 1 && [self.shoppingList.itemList count] >= 1)
             {
                [self.shoppingList.itemList removeObject:(self.shoppingList.itemList[0])];
                NSLog(@"Item's currently on ShoppingList:\n\n");
              
                for (int i=0; i < [self.shoppingList.itemList count]; i++)
                {
                   item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                   NSLog(@"%d) %@", (i+1), myItems);
                }
              }
              else if (userChoice == 2 && [self.shoppingList.itemList count] >= 2)
              {
                [self.shoppingList.itemList removeObject:(self.shoppingList.itemList[1])];
                NSLog(@"Item's currently on ShoppingList:\n\n");
              
                for (int i=0; i < [self.shoppingList.itemList count]; i++)
                {
                    item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                    NSLog(@"%d) %@", (i+1), myItems);
                }
            }
            else if (userChoice == 3 && [self.shoppingList.itemList count] >= 3)
            {
                [self.shoppingList.itemList removeObject:(self.shoppingList.itemList[2])];
                NSLog(@"Item's currently on ShoppingList:\n\n");
              
                for (int i=0; i < [self.shoppingList.itemList count]; i++)
                {
                    item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                    NSLog(@"%d) %@", (i+1), myItems);
                }
            }
            else if (userChoice == 4 && [self.shoppingList.itemList count] >= 4)
            {
                [self.shoppingList.itemList removeObject:(self.shoppingList.itemList[3])];
                NSLog(@"Item's currently on ShoppingList:\n\n");
              
                for (int i=0; i < [self.shoppingList.itemList count]; i++)
                {
                    item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                    NSLog(@"%d) %@", (i+1), myItems);
                }
            }
            else if (userChoice == 5 && [self.shoppingList.itemList count] >= 5)
            {
                [self.shoppingList.itemList removeObject:(self.shoppingList.itemList[4])];
                NSLog(@"Item's currently on ShoppingList:\n\n");
              
                for (int i=0; i < [self.shoppingList.itemList count]; i++)
                {
                    item* myItems = [self.shoppingList.itemList objectAtIndex:i];
                    NSLog(@"%d) %@", (i+1), myItems);
                }
            }
            else
            {
                NSLog(@"Sorry your item was not found on your shopping list please try again.");
            }
          //stops app from exiting with do while loop catch all at bottom of method.
          userChoice = 1;
      }
      else if (userChoice == 4)
      {
          NSLog(@"\nShow Current shopping list Page\n");
          NSLog(@"All Item's on your ShoppingList:\n\n");
          
          for (int i=0; i < [self.shoppingList.itemList count]; i++)
          {
              item* myItems = [self.shoppingList.itemList objectAtIndex:i];
              NSLog(@"%d) %@", (i+1), myItems);
          }
          
          NSLog(@"\n\nThe total cost of this Shopping list is: $%.02f" , [self.shoppingList calcTotalCost: self.shoppingList.itemList]);

      }
      else if (userChoice == 5)
      {
          NSLog(@"Exiting Shopping List Application\nThanks for using my App.");
      }
      else
      {
          NSLog(@"\n\nPLEASE ENTER A NUMBER FROM 1-5 ONLY!!\nPlease Try Again.");
      }
        
    } while (userChoice != 5 || userChoice < 0 || userChoice > 5);
    
    
    
}


@end
