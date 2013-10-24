//
//  CardImageView.h
//  Concentration
//
//  Created by Alessi Patrick on 9/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardImageView : UIImageView {
    BOOL faceDown;
    int value;
}

- (id)initWithFrame:(CGRect)aRect value:(int) inValue;
-(void) flipCard;

@property BOOL faceDown;
@property int value;

@end