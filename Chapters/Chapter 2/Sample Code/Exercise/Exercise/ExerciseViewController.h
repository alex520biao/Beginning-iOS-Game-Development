//
//  ExerciseViewController.h
//  Exercise
//
//  Created by Alessi Patrick on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewController : UIViewController {
    UILabel *textLabel;
}

@property (strong, nonatomic) IBOutlet UILabel *textLabel;

- (IBAction)tappedOne:(id)sender;
- (IBAction)tappedTwo:(id)sender;
- (IBAction)tappedThree:(id)sender;

@end
