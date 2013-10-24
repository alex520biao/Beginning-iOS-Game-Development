//
//  ViewController.m
//  TicTac
//
//  Created by Alessi Patrick on 8/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize spaceButton;
@synthesize statusLabel;

@synthesize xImage,oImage,theGameState;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Load the images
    xImage = [UIImage imageNamed:@"x.png"];
    oImage = [UIImage imageNamed:@"o.png"];
    
    // Create the game state
    theGameState = [[GameState alloc] init];
}

- (void)viewDidUnload
{
    [self setStatusLabel:nil];
    [self setSpaceButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Initialize the game
    [self initGame];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Added methods

- (void) initGame
{
    // Initialize the game
    // Set player's turn to the x player because X always goes first
    self.theGameState.playersTurn=TTxPlayerTurn;
    
    // Set the status label
    self.statusLabel.text = @"X to move";
    
    // Clear the board state
    [self.theGameState.boardState removeAllObjects];
    for (int i=0;i<=8;i++)
    {
        // Insert a space to indicate a blank in the grid
        [self.theGameState.boardState insertObject:@" " atIndex:i];
    }
    [self updateBoard];
    
}

- (void) updateBoard
{
    // Given the state, update the board
    for (int i=0;i<=8;i++)
    {
        if ([[self.theGameState.boardState objectAtIndex:i] isEqualToString:@"x"])
        {
            [[spaceButton objectAtIndex:i] setImage:self.xImage forState:UIControlStateNormal];
        }
        else if ([[self.theGameState.boardState objectAtIndex:i] isEqualToString:@"o"])
        {
            [[spaceButton objectAtIndex:i] setImage:self.oImage forState:UIControlStateNormal];
            
        }
        else
        {
            [[spaceButton objectAtIndex:i] setImage:nil forState:UIControlStateNormal];
            
        }
    }
    
}

- (BOOL) didPlayerWin: (NSString*) player
{
    // This method determines if the given player has won
    
    if (([[self.theGameState.boardState objectAtIndex:0] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:1] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:2] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:3] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:5] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:6] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:7] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:8] isEqualToString:player]) ||
        
        ([[self.theGameState.boardState objectAtIndex:0] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:3] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:6] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:1] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:7] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:2] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:5] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:8] isEqualToString:player]) ||
        
        ([[self.theGameState.boardState objectAtIndex:0] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:8] isEqualToString:player]) ||
        ([[self.theGameState.boardState objectAtIndex:2] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:4] isEqualToString:player] &&
         [[self.theGameState.boardState objectAtIndex:6] isEqualToString:player])
        )
    {
        return YES;
    }
    else
        return NO;
}

- (TTGameOverStatus) checkGameOver
{
    // This method checks to see if the game is over
    
    // Did x win?
    if ([self didPlayerWin:@"x"])
    {
        return TTGameOverxWins;
    }
    // Did o win?
    else if ([self didPlayerWin:@"o"])
    {
        return TTGameOveroWins;
    }
    
    // No winner.  Check to see if there are open spaces left on the board
    // because if there are open spaces, the game is not over
    for (int i=0; i<=8; i++) {
        if ([[self.theGameState.boardState objectAtIndex:i] isEqualToString:@" "])
        {
            // Cannot be a tie because there is an open space
            return TTGameNotOver;
        }
    }
    
    // No open spaces and no winner, so the game is a tie
    return TTGameOverTie;
    
}

- (void) updateGameStatus
{
    // Check for win or tie
    TTGameOverStatus gameOverStatus = [self checkGameOver];
    
    switch (gameOverStatus) {
        case TTGameNotOver:
            // The game is not over
            // Next player's turn
            if (self.theGameState.playersTurn == TTxPlayerTurn)
            {
                // Set the status label
                self.statusLabel.text = @"X to move";
                
            }
            else
            {
                // Set the status label
                self.statusLabel.text = @"O to move";
                
            }
            
            break;
        case TTGameOverxWins:
        case TTGameOveroWins:
        case TTGameOverTie:
            // Game is over
            [self endGameWithResult:gameOverStatus];
            break;
    } 
}

- (IBAction)spaceButtonTapped:(id)sender {
    NSLog(@"Player tapped: %i",[sender tag]);
    
    int spaceIndex = [sender tag];
    
    // If the space is blank and if it is my turn go, if not, ignore
    if ([[self.theGameState.boardState objectAtIndex:spaceIndex] isEqualToString:@" "])
    {
        
        // Update game state
        if (self.theGameState.playersTurn == TTxPlayerTurn)
        {
            [self.theGameState.boardState replaceObjectAtIndex:spaceIndex withObject: @"x"];
            
            // It is now o's turn
            self.theGameState.playersTurn = TToPlayerTurn;
            
            
        }
        else
        {
            [self.theGameState.boardState replaceObjectAtIndex:spaceIndex withObject: @"o"];
            
            // It is now x's turn
            self.theGameState.playersTurn = TTxPlayerTurn;
            
        }
        
        // Update the board
        [self updateBoard];
        
        // Update the game status
        [self updateGameStatus];
    }
}
-(void) endGameWithResult:(TTGameOverStatus) result
{
    NSString* gameOverMessage;
    
    switch (result) {
        case TTGameOverxWins:
            gameOverMessage = [NSString stringWithString:@"X wins"];
            break;
        case TTGameOveroWins:
            gameOverMessage = [NSString stringWithString:@"O wins"];
            break;
        case TTGameOverTie:
            gameOverMessage = [NSString stringWithString:@"The game is a tie"];
            break;
        default:
            break;
    }
    
    // Show an alert with the results
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:gameOverMessage
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show]; 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Reset the game
    [self initGame];
    
}
@end
