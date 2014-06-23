//
//  AddItemController.m
//  shoppingList
//
//  Created by Eddie Power on 2/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "AddItemController.h"
#import "UIColor+ItemColor.h"

@implementation AddItemController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadItemData];
}

-(void)downloadItemData
{
    double lastUpdate = [self loadLastUpdate];
    
    NSLog(@"Last update was: %f", lastUpdate);
    
    NSURL* url;
    if(lastUpdate == -1)
    {
        url = [NSURL URLWithString:@"http://elliott-wilson.com/items/allItems.php"];
    }
    else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://elliott-wilson.com/items/allItems.php?lastChecked=%f", lastUpdate]];
    }
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
        if(error == nil)
        {
            [self parseItemJSON:data];
            [self fetchItemData];
            [self saveLastUpdate];
        }
        else
        {
            NSLog(@"AddItemController.m: Connection to JSON data error:\n%@", error.userInfo);
        }
     }];
}

-(void)fetchItemData
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ItemData"];
    NSSortDescriptor* nameSort = [NSSortDescriptor sortDescriptorWithKey:@"item_name" ascending:YES];
    [fetchRequest setSortDescriptors:@[nameSort]];
    
    NSError* error;
    self.allItems = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (self.allItems == nil)
    {
        NSLog(@"AddItemController.m: Could not fetch Item Data:\n%@", error.userInfo);
    }
    
    [self.tableView reloadData];
}

-(void)saveLastUpdate
{
    NSDate* currentDate = [NSDate date];
    NSNumber* epochTime = [NSNumber numberWithDouble:[currentDate timeIntervalSince1970]];
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:epochTime forKey:@"lastUpdate"];
    
    NSError* error;
    NSData* plist = [NSPropertyListSerialization dataWithPropertyList:dictionary format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"lastUpdate.plist"];
    [plist writeToFile:plistPath atomically:YES];
}

-(double)loadLastUpdate
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"lastUpdate.plist"];
    NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
    
    if (plistData == nil)
    {
        NSLog(@"No plistData, it probably dosn't exist yet!");
        return -1;
    }
    
    NSError *error;
    id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:nil error:&error];
    
    if(plist == nil)
    {
        NSLog(@"Error opening file:\n%@", error.userInfo);
        return -1;
    }
    
    if ([plist isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)plist;
        NSNumber* lastUpdate = [dict valueForKey:@"lastUpdate"];
        return [lastUpdate doubleValue];
    }
    
    return -1;
}

-(void)parseItemJSON:(NSData*)data
{
    NSError* error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (result == nil)
    {
        NSLog(@"AddItemController.m: \nError parsing the JSON list:\n%@", error.userInfo);
        return;
    }
    
    if ([result isKindOfClass:[NSArray class]])
    {
        NSArray* itemArray = (NSArray*)result;
        NSLog(@"Found %lu new items!", (unsigned long)[itemArray count]);
        
        //Loop through the stored NSDict which comes from the JSON look up result.
        for (NSDictionary* item in itemArray)
        {
            //Store the item data.
            ItemData* itemData = [NSEntityDescription insertNewObjectForEntityForName:@"ItemData" inManagedObjectContext:self.managedObjectContext];
            itemData.item_name = [item objectForKey:@"name"];
            itemData.item_description = [item objectForKey:@"description"];
            itemData.item_price = [item objectForKey:@"price"];
            
            //NSLog(@"!!!!!!EDDIE DEBUG: inside AddItemController.m runningparseItemJSON method.\nitemData is: %@", itemData.item_name);
        }
        
        NSError* error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Could not save downloaded item data:\n%@", error.userInfo);
        }
    }
    else
    {
        NSLog(@"AddItemController.m:\nUnexpected JSON format!");
        return;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    ItemCell *cell = (ItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the item cell labels with data from database...
    Item* i = [self.allItems objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = i.item_name;
    cell.nameLabel.textColor = [UIColor colorForItem: i.item_name];
    cell.descriptionLabel.text = i.item_description;
    
    //Format the number data type item_price to show up as a currency with a doller sign.
    // see item.h for info on why NSNumber.
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *priceFormated = [formatter stringFromNumber:i.item_price];
    //Output the price.
    cell.priceLabel.text = [NSString stringWithFormat:@"Price: %@", priceFormated];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //As above but this is used to store the new item to the listView via the managedObjContext or store.
    ItemData* selectedItemData = [self.allItems objectAtIndex:indexPath.row];
    
    Item* newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    newItem.item_name = selectedItemData.item_name;
    newItem.item_description = selectedItemData.item_description;
    newItem.item_price = selectedItemData.item_price;
    
    [self.delegate addItem: newItem];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
