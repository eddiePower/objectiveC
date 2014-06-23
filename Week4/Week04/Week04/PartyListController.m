//
//  PartyListController.m
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import "PartyListController.h"

@implementation PartyListController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.currentParty = [[NSMutableArray alloc] init];
    }
    return self;
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
                return [self.currentParty count];
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
        Monster* m = [self.currentParty objectAtIndex:indexPath.row];
        cell.nameLabel.text = m.name;
        
        cell.attackLabel.text = [NSString stringWithFormat:@"Attack Power: %d", m.attackPower];
        //cell.attackLabel.text = @"Attack Power: TEST";
        
        if([m.type isEqualToString:@"Grass"])
        {
            cell.attackLabel.textColor = [UIColor greenColor];
        }
        else if([m.type isEqualToString:@"Fire"])
        {
            cell.attackLabel.textColor = [UIColor redColor];
        }
        else if([m.type isEqualToString:@"Water"])
        {
            cell.attackLabel.textColor = [UIColor blueColor];
        }
        else if([m.type isEqualToString:@"Electric"])
        {
            cell.attackLabel.textColor = [UIColor cyanColor];
        }
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Total Monsters: %d", [self.currentParty count]];
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
        [self.currentParty removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddMonsterSegue"])
    {
        AddMonsterController* controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

-(void)addMonster:(Monster *)monster
{
    [self.currentParty addObject:monster];
    [self.tableView reloadData];
}

@end
