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

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MonsterData"];
    
    NSError* error;
    self.allMonsters = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (self.allMonsters == nil)
    {
        NSLog(@"Could not fetch Monster Data:\n%@", error.userInfo);
    }
    else if([self.allMonsters count] == 0)
    {
        [self addMonsterData];
    }
}

-(void)addMonsterData
{
    MonsterData* data = [NSEntityDescription insertNewObjectForEntityForName:@"MonsterData" inManagedObjectContext:self.managedObjectContext];
    data.name = @"Bulbasaur";
    data.type = @"Grass";
    
    data = [NSEntityDescription insertNewObjectForEntityForName:@"MonsterData" inManagedObjectContext:self.managedObjectContext];
    data.name = @"Charmander";
    data.type = @"Fire";
    
    data = [NSEntityDescription insertNewObjectForEntityForName:@"MonsterData" inManagedObjectContext:self.managedObjectContext];
    data.name = @"Squirtle";
    data.type = @"Water";
    
    data = [NSEntityDescription insertNewObjectForEntityForName:@"MonsterData" inManagedObjectContext:self.managedObjectContext];
    data.name = @"Pikachu";
    data.type = @"Electric";
    
    NSError* error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Could not save initial Monster Data:\n%@", error.userInfo);
    }
    else
    {
        NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MonsterData"];
        self.allMonsters = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (self.allMonsters == nil)
        {
            NSLog(@"Could not assign monster data:\n%@", error.userInfo);
        }
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
