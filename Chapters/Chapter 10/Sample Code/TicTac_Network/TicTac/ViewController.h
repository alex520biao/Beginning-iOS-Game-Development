//
//  ViewController.h
//  TicTac
//
//  Created by Alessi Patrick on 8/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameState.h"
#import <GameKit/GameKit.h>

typedef enum {
    TTGameNotOver = 0,            // The game is not over
    TTGameOverxWins = 1,            // The x player won
    TTGameOveroWins = 2,            // The o player won
    TTGameOverTie = 3,              // The game is a tie
} TTGameOverStatus;

typedef enum {
    TTMyShapeUndetermined = 0,
    TTMyShapeX = 1,
    TTMyShapeO= 2 
} TTMyShape;

@interface ViewController : UIViewController <GKPeerPickerControllerDelegate>
{
    UIImage* xImage;
    UIImage* oImage;
    
    // The game state
    GameState* theGameState;

    // Which player am I
    TTMyShape myShape;
    
    // Store my UUID
    NSString* myUUID;
    
    // Gamekit variables
    GKSession* theSession;
    NSString* myPeerID; 
}
@property (strong, nonatomic) UIImage* xImage;
@property (strong, nonatomic) UIImage* oImage;
@property (strong, nonatomic) GameState* theGameState;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *spaceButton;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *playerLabel;

@property TTMyShape myShape;
@property (strong, nonatomic) NSString* myUUID;

// Gamekit properties
@property (strong, nonatomic) IBOutlet GKSession* theSession;
@property (strong, nonatomic) IBOutlet NSString* myPeerID;

- (IBAction)spaceButtonTapped:(id)sender;

- (void) initGame;
- (void) updateBoard;
- (void) updateGameStatus;
- (TTGameOverStatus) checkGameOver;
- (BOOL) didPlayerWin: (NSString*) player;
- (void) endGameWithResult:(TTGameOverStatus) result;
- (NSString *)getUUIDString;


@end
