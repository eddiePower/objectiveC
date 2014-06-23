//
//  PartyListController.m
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import "PartyListController.h"
#import "UIColor+MonsterColor.h"

@implementation PartyListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Party"];
    
    NSError* error;
    NSArray* result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (result == nil)
    {
        NSLog(@"Could not fetch Party:\n%@", error.userInfo);
    }
    else if ([result count] == 0)
    {
        self.currentParty = [NSEntityDescription insertNewObjectForEntityForName:@"Party" inManagedObjectContext:self.managedObjectContext];
    }
    else
    {
        self.currentParty = [result firstObject];
        self.partyMonsterList = [self.currentParty.members allObjects];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
            case 0:
                return [self.partyMonsterList count];
            case 1:
                return 1;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        MonsterCell *cell = (MonsterCell*)[tableView dequeueReusableCellWithIdentifier:@"MonsterCell" forIndexPath:indexPath];
        
        //configure the cell for show party list.
        Monster* m = [self.partyMonsterList objectAtIndex:indexPath.row];
        cell.nameLabel.text = m.name;
        cell.attackLabel.text = [NSString stringWithFormat:@"Attack Power: %@", m.attackPower];
       
        
        cell.attackLabel.textColor = [UIColor colorForType:m.type];
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Total Monsters: %d", [self.partyMonsterList count]];
        return cell;
    }
    
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return YES;
    
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Monster* monsterToRemove = [self.partyMonsterList objectAtIndex:indexPath.row];
        
        [self.currentParty removeMembersObject:monsterToRemove];
        
        self.partyMonsterList = [self.currentParty.members allObjects];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]
                              withRowAnimation:UITableViewRowAnimationFade];
        
        NSError* error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Could not save deletion:\n%@", error.userInfo);
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddMonsterSegue"])
    {
        AddMonsterController* controller = segue.destinationViewController;
        controller.managedObjectContext = self.managedObjectContext;
        controller.delegate = self;
    }
}

-(void)addMonster:(Monster *)monster
{
    [self.currentParty addMembersObject:monster];
    self.partyMonsterList = [self.currentParty.members allObjects];
    [self.tableView reloadData];
    NSError* error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Could not save monster insertion:\n%@", error.userInfo);
    }
}

@end
