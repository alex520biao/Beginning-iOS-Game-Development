//
//  ViewController.h
//  TicTac
//
//  Created by Alessi Patrick on 8/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameState.h"

typedef enum {
    TTGameNotOver = 0,            // The game is not over
    TTGameOverxWins = 1,            // The x player won
    TTGameOveroWins = 2,            // The o player won
    TTGameOverTie = 3,              // The game is a tie
} TTGameOverStatus;

@interface ViewController : UIViewController
{
    UIImage* xImage;
    UIImage* oImage;
    
    // The game state
    GameState* theGameState;
}
@property (strong, nonatomic) UIImage* xImage;
@property (strong, nonatomic) UIImage* oImage;
@property (strong, nonatomic) GameState* theGameState;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *spaceButton;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)spaceButtonTapped:(id)sender;

- (void) initGame;
- (void) updateBoard;
- (void) updateGameStatus;
- (TTGameOverStatus) checkGameOver;
- (BOOL) didPlayerWin: (NSString*) player;
- (void) endGameWithResult:(TTGameOverStatus) result;

@end
