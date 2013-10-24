//
//  main.c
//  CSizes
//
//  Created by Patrick Alessi on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>


int main (int argc, const char * argv[])
{

    printf ("Size of int: %lu \n", sizeof(int));
    printf ("Size of char: %lu \n", sizeof(char));
    printf ("Size of float: %lu \n", sizeof(float));
    printf ("Size of double: %lu \n", sizeof(double));
    
    printf ("Size of short int: %lu \n", sizeof(short int));
    printf ("Size of long double: %lu \n", sizeof(long double));

    
    int i = 0;
    printf("i: %i\n",i);
    printf("i++: %i\n",i++);
    printf("i: %i\n\n",i);
    
    i=0;
    printf("i: %i\n",i);
    printf("++i: %i\n",++i);
    printf("i: %i\n",i);

    return 0;
}

