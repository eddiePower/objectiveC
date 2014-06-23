//
//  Card.m
//  Matchismo
//
//  Created by Eddie Power on 23/04/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

@end
