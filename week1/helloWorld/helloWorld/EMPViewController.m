//
//  EMPViewController.m
//  helloWorld
//
//  Created by Eddie Power on 4/03/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import "EMPViewController.h"

@interface EMPViewController ()

@end

@implementation EMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sayHelloButtonPressed:(id)sender
{
    NSLog(@"Label reads, ");
    [helloWorldLabel setText:@"hello World!"];
}

@end
