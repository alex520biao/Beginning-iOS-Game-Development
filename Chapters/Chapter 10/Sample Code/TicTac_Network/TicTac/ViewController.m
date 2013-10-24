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
@synthesize playerLabel;

@synthesize xImage,oImage,theGameState;

@synthesize myShape,myUUID;

// Synthesize gamekit properties
@synthesize theSession,myPeerID;

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
    
    // Initialize my shape to undetermined
    myShape = TTMyShapeUndetermined;
    
    // Generate my UUID
    myUUID = [self getUUIDString];
}

- (void)viewDidUnload
{
    [self setStatusLabel:nil];
    [self setSpaceButton:nil];
    [self setPlayerLabel:nil];
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
    
    // Show the peer picker
    GKPeerPickerController* picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    
    [picker show];

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

- (NSString *)getUUIDString
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result = [NSString stringWithFormat:@"%@", uuidStr];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
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
    if ([[self.theGameState.boardState objectAtIndex:spaceIndex] isEqualToString:@" "]
        && self.myShape == self.theGameState.playersTurn)
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
        
        
        
        // Send the new game state out to peers
        NSData* theData = [NSKeyedArchiver archivedDataWithRootObject:self.theGameState];
        NSError* error;
        
        [self.theSession sendDataToAllPeers:theData withDataMode:GKSendDataReliable error:&error];

        
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


#pragma mark - GKPeerPickerControllerDelegate methods

- (void)peerPickerController:(GKPeerPickerController *)picker 
              didConnectPeer:(NSString *)peerID 
                   toSession:(GKSession *)session
{
    // Tells the delegate that the controller connected a peer to the session.
    // Once a peer is connected to the session, your application should take 
    // ownership of the session, dismiss the peer picker, and then use the 
    // session to communicate with the other peer.
    
    // Store off the session
    self.theSession= session;
    
    // Store the Peer ID
    self.myPeerID = peerID;
    
    // Set the receive data handler
    [session setDataReceiveHandler:self withContext:nil];        
    
    // Dismiss the picker
    [picker dismiss];
    
    // Session is connected so negotiate shapes
    // Send out UUID
    NSData* theData = [NSKeyedArchiver archivedDataWithRootObject:self.myUUID];
    NSError* error;
    
    [self.theSession sendDataToAllPeers:theData withDataMode:GKSendDataReliable error:&error];
    
}


- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer 
           inSession: (GKSession *)session context:(void *)context
{
    // The receive data handler
    NSLog(@"Received data");
    
    // If myShape == TTMyShapeUndetermined we should get shape negotiation data
    if (myShape == TTMyShapeUndetermined)
    {
        NSString* peerUUID = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([myUUID compare:peerUUID] == NSOrderedAscending)
        {
            myShape = TTMyShapeX;
            self.playerLabel.text = @"You are X";
        }
        else
        {
            myShape = TTMyShapeO;
            self.playerLabel.text = @"You are O";
        }
    }    
    else
    {
        // Update the board state with the received data
        self.theGameState = [NSKeyedUnarchiver unarchiveObjectWithData:data] ;
        
        // Received data so update the board and the game status
        [self updateBoard];
        [self updateGameStatus];
    }
    
}
@end
