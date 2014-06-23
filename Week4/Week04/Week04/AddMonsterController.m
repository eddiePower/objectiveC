//
//  AddMonsterController.m
//  Project Name: Week04
//
//  Created by Eddie Power on 26/03/2014.
//  Copyright (c) 2014 Eddie Power.
//  All rights reserved.
//

#import "AddMonsterController.h"

@implementation AddMonsterController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        Monster* m1 = [[Monster alloc] initWithName:@"Bulbasuar" attackPower:100 andType:@"Grass"];
        Monster* m2 = [[Monster alloc] initWithName:@"Charmander" attackPower:150 andType:@"Fire"];
        Monster* m3 = [[Monster alloc] initWithName:@"Squirtle" attackPower:130 andType:@"Water"];
        Monster* m4 = [[Monster alloc] initWithName:@"Pikachu" attackPower:110 andType:@"Electric"];
        self.allMonsters = [NSArray arrayWithObjects:m1, m2, m3, m4, nil];
    }
    return self;
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
    Monster* m = [self.allMonsters objectAtIndex:indexPath.row];
    cell.nameLabel.text = m.name;
   
    cell.attackLabel.text = [NSString stringWithFormat:@"Attack Power: %d", m.attackPower];
    //cell.attackLabel.text = @"Attack Power: TEST";
    
    if ([m.type isEqualToString:@"Grass"])
    {
        cell.attackLabel.textColor = [UIColor greenColor];
    }
    else if ([m.type isEqualToString:@"Fire"])
    {
        cell.attackLabel.textColor = [UIColor redColor];
    }
    else if ([m.type isEqualToString:@"Water"])
    {
        cell.attackLabel.textColor = [UIColor blueColor];
    }
    else if ([m.type isEqualToString:@"Electric"])
    {
        cell.attackLabel.textColor = [UIColor cyanColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Monster* selectedMonster = [self.allMonsters objectAtIndex:indexPath.row];
    [self.delegate addMonster: selectedMonster];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
