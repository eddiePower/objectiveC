//
//  AddMonsterController.m
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import "AddMonsterController.h"
#import "UIColor+MonsterColor.h"

@implementation AddMonsterController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadMonsterData];
}

-(void)downloadMonsterData
{
    double lastUpdate = [self loadLastUpdate];
    
    NSLog(@"Last Update was: %f", lastUpdate);
    
    NSURL* url;
    if(lastUpdate == -1)
    {
        url = [NSURL URLWithString:@"http://elliott-wilson.com/monsters/allMonsters.php"];
    }
    else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://elliott-wilson.com/monsters/allMonsters.php?lastChecked=%f", lastUpdate]];
    }
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
        if(error == nil)
        {
            [self parseMonsterJSON:data];
            [self fetchMonsterData];
            [self saveLastUpdate];
        }
        else
        {
            NSLog(@"Connection Error:\n%@", error.userInfo);
        }
     }];
}

-(void)fetchMonsterData
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MonsterData"];
    NSSortDescriptor* nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[nameSort]];
    
    NSError* error;
    self.allMonsters = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(self.allMonsters == nil)
    {
        NSLog(@"Could not fetch Monster Data:\n%@", error.userInfo);
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
    //find the app document directory
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //add
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"lastUpdate.plist"];
    NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
    
    if(plistData == nil)
    {
        NSLog(@"No plistData, probably dosn't exist.\nPlist Location is: %@", plistPath);
        return -1;
    }
    
    NSError *error;
    
    id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:nil error:&error];
    
    if(plist == nil)
    {
        NSLog(@"Error opening file:\n%@", error.userInfo);
        return -1;
    }
    
    if([plist isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)plist;
        NSNumber* lastUpdate = [dict valueForKey:@"lastUpdate"];
        return [lastUpdate doubleValue];
    }
    
    return -1;
}

-(void)parseMonsterJSON:(NSData*)data
{
    NSError* error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(result == nil)
    {
        NSLog(@"Error parsing JSON:\n%@", error.userInfo);
        return;
    }
    
    if([result isKindOfClass:[NSArray class]])
    {
        NSArray* monsterArray = (NSArray*)result;
        NSLog(@"Found %lu new monsters!", (unsigned long)[monsterArray count]);
        
        for(NSDictionary* monster in monsterArray)
        {
            MonsterData* monsterData = [NSEntityDescription insertNewObjectForEntityForName:@"MonsterData" inManagedObjectContext:self.managedObjectContext];
            monsterData.name = [monster objectForKey:@"name"];
            monsterData.type = [monster objectForKey:@"type"];
        }
        
        NSError* error;
        if(![self.managedObjectContext save:&error])
        {
            NSLog(@"Could not save downloaded monster data:\n%@", error.userInfo);
        }
    }
    else
    {
        NSLog(@"Unexpected JSON format");
        return;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allMonsters count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MonsterCell";
    MonsterCell *cell = (MonsterCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //configure the cell for AddMonster View.
    MonsterData* m = [self.allMonsters objectAtIndex:indexPath.row];
    cell.nameLabel.text = m.name;
    cell.attackLabel.text = [NSString stringWithFormat:@"Type: %@", m.type];
    
    cell.attackLabel.textColor = [UIColor colorForType:m.type];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonsterData* selectedMonsterData = [self.allMonsters objectAtIndex:indexPath.row];
    
    Monster* newMonster = [NSEntityDescription insertNewObjectForEntityForName:@"Monster" inManagedObjectContext:self.managedObjectContext];
    newMonster.name = selectedMonsterData.name;
    newMonster.type = selectedMonsterData.type;
    int attackPower = arc4random() % 100;
    newMonster.attackPower = [NSNumber numberWithInt:attackPower];
    
    [self.delegate addMonster:newMonster];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
