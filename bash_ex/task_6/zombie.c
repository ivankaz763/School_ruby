#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
 
int main()
{
    // Creating a Child Process
    int pid = fork();
   
    if (pid > 0)         // True for Parent Process 
        sleep(60);                  
    else if (pid == 0)   // True for Child Process
        exit(0);
   
    return 0;
}
