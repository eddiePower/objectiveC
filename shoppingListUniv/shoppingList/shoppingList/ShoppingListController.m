//
//  ShoppingListController.m
//  shoppingList
//
//  Created by Eddie Power on 2/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "ShoppingListController.h"
#import "UIColor+ItemColor.h"

@implementation ShoppingListController

/*
 *
 * This viewDidLoad will check the old shoppingList by using the fetchRequest
 *  if there is no result is found then there a problem retrieving the shoppingList
 * otherwise if the list is empty then show empty list otherwise copy the whole array to
 * a variable to work with and also copy all items from the list to a variable to work with.
 *
 */
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ShoppingList"];
    
    NSError* error;
    NSArray* result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (result == nil)
    {
        NSLog(@"Could not fetch ShoppingList:\n%@", error.userInfo);
    }
    else if([result count] == 0)
    {
        self.currentShoppingList = [NSEntityDescription insertNewObjectForEntityForName:@"ShoppingList" inManagedObjectContext:self.managedObjectContext];
    }
    else
    {
        self.currentShoppingList = [result firstObject];
        self.shoppingListItems = [self.currentShoppingList.shoppingList_items allObjects];
        //NSLog(@"EDDIE DEBUG LINE: the current list Items are: \n%@", [result firstObject]);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            //check how many rows are in our table view by counting
            // each one for each item in shoppingListItems.
            return [self.shoppingListItems count];
        case 1:
            return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        ItemCell *cell = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
        
        // Configure the Item cell with text, text color & price.
        Item* i = [self.shoppingListItems objectAtIndex:indexPath.row];
        cell.nameLabel.text = i.item_name;
        cell.descriptionLabel.text = i.item_description;
        
        //Use the catagory extending the UIColor class to set the item name depending on its name.
        cell.nameLabel.textColor = [UIColor colorForItem: i.item_name];
        
        //Format the number data type for item_price to appear in a currency format.
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        //this gives the $ and rounds the decimal places off to 2.
        formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        //store a string of the formatted number item_price.
        NSString *priceFormated = [formatter stringFromNumber: i.item_price];
        
        //Debug line to check format of price in the console.
        //NSLog(@"%@", priceFormated);
        
        //Apply the formatted text to the UI price label view.
        cell.priceLabel.text = [NSString stringWithFormat:@"Price: %@", priceFormated];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalPriceCell"forIndexPath:indexPath];
        /*
         * Show the List Total by calling calcTotal Cost on the current list, then update
         *  the GUI text label at the bottom of the main view with
         *  total list price formatted as a number with 2 decimal places.
         */
        cell.textLabel.text = [NSString stringWithFormat:@"List Total: $%.2f", [self.currentShoppingList calcTotalCost: self.shoppingListItems]];
                               
        return cell;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return YES;
    return NO;
}

/* If the editing style is the delete type editing and then remove
 * the item from the location of that row and fade the old row 
 * out of the view. Update the shoppingListItems variable then
 * Error Checking that the save of the managedObjectContext delete was ok.
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Item* itemToRemove = [self.shoppingListItems objectAtIndex:indexPath.row];
        
        //remove item from list by using the object/item its self as the selection to remove.
        [self.currentShoppingList removeShoppingList_itemsObject:itemToRemove];
        self.shoppingListItems = [self.currentShoppingList.shoppingList_items allObjects];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
        
        //If there was an error with managedObjCont save show the user.
        NSError* error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Could not save deletion:\n%@", error.userInfo);
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //The seque is the slide motion from one view to another in this case the AddItemSegue.
    if([segue.identifier isEqualToString:@"AddItemSegue"])
    {
        AddItemController* controller = segue.destinationViewController;
        controller.managedObjectContext = self.managedObjectContext;
        controller.delegate = self;
    }
}
/*
 * Add item passed to the current shoppingList, update the
 *  shoppingListItems and then reload the view to show the new item
 * Do error checking on the save of the new item to the managedObjContext - (a view of a store).
 */
-(void)addItem:(Item *)item
{
    //Add item to the mainView or shoppingList.
    [self.currentShoppingList addShoppingList_itemsObject:item];
    self.shoppingListItems = [self.currentShoppingList.shoppingList_items allObjects];
    [self.tableView reloadData];

    //If there was an error with managedObjCont save show the user.
    NSError* error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Could not save Item insertion:\n%@", error.userInfo);
    }
}

@end
