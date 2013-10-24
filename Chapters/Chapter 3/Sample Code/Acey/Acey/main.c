//
//  main.c
//  Acey
//
//  Created by Patrick Alessi on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct card {
    char* name;
    char* suit;
    int value;
};

void shuffle(struct card* deck) {
    //	Seed the random number generator
    srandom( time( NULL ) );
    int i=0;
    int randomA, randomB;
    struct card tempCard;
    
    do {
        // Generate 2 random numbers to determine which cards to swap
        randomA = random() % 52;
        randomB = random() % 52;
        
        // Swap slots A and B
        tempCard = deck[randomA];
        deck[randomA] = deck[randomB];
        deck[randomB] = tempCard;
        
        // Increment the counter
        i++;
    }
    while (i<1000000);
    
}

int main (int argc, const char * argv[])
{
    
    struct card deck[] =
    {
        {"ace", "spades",1}, {"two", "spades",2}, {"three", "spades",3},
        {"four", "spades",4}, {"five", "spades",5}, {"six", "spades",6},
        {"seven", "spades",7}, {"eight", "spades",8}, {"nine", "spades",9},
        {"ten", "spades",10}, {"jack", "spades",11}, {"queen", "spades",12},
        {"king", "spades",13},
        {"ace", "clubs",1}, {"two", "clubs",2}, {"three", "clubs",3},
        {"four", "clubs",4}, {"five", "clubs",5}, {"six", "clubs",6},
        {"seven", "clubs",7}, {"eight", "clubs",8}, {"nine", "clubs",9},
        {"ten", "clubs",10}, {"jack", "clubs",11}, {"queen", "clubs",12},
        {"king", "clubs",13},
        {"ace", "hearts",1}, {"two", "hearts",2}, {"three", "hearts",3},
        {"four", "hearts",4}, {"five", "hearts",5}, {"six", "hearts",6},
        {"seven", "hearts",7}, {"eight", "hearts",8}, {"nine", "hearts",9},
        {"ten", "hearts",10}, {"jack", "hearts",11}, {"queen", "hearts",12},
        {"king", "hearts",13},
        {"ace", "diamonds",1}, {"two", "diamonds",2}, {"three", "diamonds",3},
        {"four", "diamonds",4}, {"five", "diamonds",5}, {"six", "diamonds",6},
        {"seven", "diamonds",7}, {"eight", "diamonds",8}, 
        {"nine", "diamonds",9},{"ten", "diamonds",10}, {"jack", "diamonds",11}, 
        {"queen", "diamonds",12}, {"king", "diamonds",13}, 
        {"sentinel", "null", 0}                
    };
    
    // Create the player's bank and start it off with 100 credits
    int bank=100;
    
    // Create a pointer to the deck
    struct card* pDeck = deck;
    
    // Create a variable to hold the bet
    int bet=0;
    
    // Run the function to shuffle the deck
    shuffle(deck);
    
    // Run the game in a loop. Continue as long as the bank is > and none of 
    // the next three cards are the sentinel
    do {
        // Print the amount of credits in the bank
        printf("Your bank: %i\n", bank);

        // Print the cards
        printf("The cards: ");

        // First card
        printf("%s of %s ", pDeck->name, pDeck->suit);
        
        // Move to the next card
        pDeck++;
        
        // Second card
        printf("and %s of %s\n", pDeck->name, pDeck->suit);
        
        // Move the pointer to the next card
        pDeck++;
        
        // Ask for the bet
        // Do this in a loop because we cannot accept bets greater than the 
        // amount that the player has in the bank and we cannot
        // accept a 0 bet
        do {
            printf("Enter your bet: ");
            scanf("%i", &bet);        
        }
        while (bet <= 0 || bet > bank );
        
        // Draw the third card
        printf("The third card is %s of %s\n", pDeck->name, pDeck->suit);
        
        // Determine if the player won
        // The player is a winner if the third card falls between the first two
        // Ties go to the house
        if (((pDeck-2)->value < pDeck-> value && 
             (pDeck-1)->value > pDeck->value) ||
            ((pDeck-2)->value > pDeck-> value && 
             (pDeck-1)->value < pDeck->value)) {
            printf("We have a winner!\n\n");
            
            // Player won, add bet to the bank
            bank += bet;
            
        }
        else {
            printf("Sorry, you lose.\n\n");
            // Player lost, subsract bet from the bank
            bank -= bet;
        }
        
        // Move to the next card
        pDeck++;
        
    }
    while (bank > 0 && 
           pDeck->value!=0 && 
           (pDeck+1)->value!=0 &&
           (pDeck+2)->value!=0);
    
    // The game is over
    printf("The game is over. Your final score is %i\n", bank);
    
    
    return 0;
}


