//
//  SampleUIViewController.h
//  SampleUI
//
//  Created by Alessi Patrick on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleUIViewController : UIViewController {
    UILabel *myLabel;
    IBOutlet UISlider *mySlider;
    int counter;
}
- (IBAction)buttonPressed:(id)sender;
- (IBAction)sliderMoved:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *myLabel;

@end
