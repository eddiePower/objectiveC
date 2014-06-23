//
//  EMPViewController.h
//  helloWorld
//
//  Created by Eddie Power on 4/03/2014.
//  Copyright (c) 2014 Eddie Power. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMPViewController : UIViewController
{
    IBOutlet UILabel *helloWorldLabel;
}

- (IBAction)sayHelloButtonPressed:(id)sender;

@end
