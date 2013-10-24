//
//  BlockerModel.m
//  Blocker
//
//  Created by Alessi Patrick on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BlockerModel.h"

@implementation BlockerModel
@synthesize blocks,ballRect,paddleRect;


// Override superclass implementation of init so that we can provide a properly
// initialized game model
- (id)init {
    self = [super init];
    
    if (self) {
        // Init blocks
        // The array to hold the blocks
        blocks = [[NSMutableArray alloc] initWithCapacity:15];
        
        BlockView* bv;
        
        for (int row = 0; row<=2; row++)
        {
            for (int col = 0; col<5; col++)
            {
                bv = [[BlockView alloc ] 
                      initWithFrame: CGRectMake(col * BLOCK_WIDTH ,
                                                row * BLOCK_HEIGHT,
                                                BLOCK_WIDTH, BLOCK_HEIGHT)
                      color:row];
                
                //	Add the tile to the view
                [blocks addObject:bv];
                
            }
        }
        
        // Set the paddle rect by using the size of the paddle image
        UIImage* paddleImage = [UIImage imageNamed:@"paddle.png"];
        CGSize paddleSize = [paddleImage size];
        paddleRect = CGRectMake(0.0, 420.0, 
                                paddleSize.width, paddleSize.height);
        
        // Set the ball rect by using the size of the paddle image
        UIImage* ballImage = [UIImage imageNamed:@"ball.png"];
        CGSize ballSize = [ballImage size];
        ballRect = CGRectMake(180.0, 220.0, 
                              ballSize.width, ballSize.height);
        
        // Set the initial velocity for the ball
        ballVelocity = CGPointMake(200.0, -200.0);
        
        // Initialize the lastTime
        lastTime = 0.0;
        
        // Init audio players
        NSURL *blockSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle]
                                                        pathForResource: @"0"
                                                        ofType: @"aiff"]];
        
        blockPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:blockSoundURL 
                                                             error:nil];
        
        NSURL *paddleSoundURL = [NSURL fileURLWithPath: [[NSBundle mainBundle] 
                                                         pathForResource: @"2"
                                                         ofType: @"aiff"]];
        
        paddlePlayer = [[AVAudioPlayer alloc] 
                        initWithContentsOfURL:paddleSoundURL 
                        error:nil];
        
        // Prepare to play sounds
        [blockPlayer prepareToPlay];
        [paddlePlayer prepareToPlay];
        
    }
    
    return self;
}

- (void) checkCollisionWithScreenEdges {
    // Change ball direction if it hit an edge of the screen
    // Left edge
    if (ballRect.origin.x <= 0)
    {
        // Flip the x velocity component
        ballVelocity.x = abs(ballVelocity.x);
    }
    
    // Right edge
    if (ballRect.origin.x >= VIEW_WIDTH - BALL_SIZE)
    {
        // Flip the x velocity component
        ballVelocity.x = -1 * abs(ballVelocity.x);
    }
    
    // Top edge
    if (ballRect.origin.y <=  0)
    {
        // Flip the x velocity component
        ballVelocity.y = abs(ballVelocity.y);
    }
    
    // Bottom edge
    if (ballRect.origin.y >=  VIEW_HEIGHT - BALL_SIZE)
    {
        // Ball went off the bottom of the screen
        // In a production game, you'd want to reduce the player's
        // ball count by one and reset the ball.  To keep this example
        // simple, we are not keeping score or ball count. We'll
        // just reset the ball
        
        ballRect.origin.x = 180.0;
        ballRect.origin.y = 220.0;
        
        // Flip the y velocity component
        ballVelocity.y = -1*abs(ballVelocity.y);
        
        
    }
    
}

- (void) checkCollisionWithBlocks {
    // Iterate over the blocks to see if a collision has happened
    for (BlockView* bv in blocks) {
        if (CGRectIntersectsRect(bv.frame,ballRect)) {
            // Flip the y velocity component
            ballVelocity.y = -ballVelocity.y;
            
            // Remove the block from the collection
            [blocks removeObject:bv];
            
            // remove the block's view from the superview
            [bv removeFromSuperview];
            
            // In a production game, you'd want to add to the player's score
            // here, when a block is hit. To keep this example
            // simple, we are not keeping score.
            
            // Play the block collision sound
            [blockPlayer play];
            
            break;
        }
        
    }
    
}

- (void) checkCollisionWithPaddle {
    // Check to see if the paddle has blocked the ball
    if (CGRectIntersectsRect(ballRect,paddleRect)) {
        // Flip the y velocity component
        ballVelocity.y = -1 * abs( ballVelocity.y);
        
        // Play the paddle sound
        [paddlePlayer play];
        
    }
}

-(void) updateModelWithTime:(CFTimeInterval) timestamp{
    if (lastTime == 0.0)
    {
        // First time through, initialize the lastTime
        lastTime = timestamp;
    }
    else
    {
        // Calculate time elapsed since last call
        timeDelta = timestamp - lastTime;
        
        // Update the lastTime
        lastTime = timestamp;
        
        // Calculate new position of the ball
        ballRect.origin.x += ballVelocity.x * timeDelta;
        ballRect.origin.y += ballVelocity.y * timeDelta;
        
        // Check for collision with screen edges
        [self checkCollisionWithScreenEdges];
        
        
        // Do collision detection with blocks
        [self checkCollisionWithBlocks];
        
        // Do collision detection with paddle
        [self checkCollisionWithPaddle];
        
    }
    
}

@end
