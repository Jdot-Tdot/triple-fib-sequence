#include <stdio.h>
#include <stdlib.h>

/// easier input validation.
int getprompt(char prompt[]) {
        int temp_input;
        while(1) 
        {
            printf(prompt);
            scanf("%d", &temp_input);
            if (temp_input >= 0) break;
        }
        return temp_input;
    }

int main() {
    /// stuff we just want the same as our asm file so it is easier to handle.
    char prompt0[] = "Enter tribonacci(0): ";
    char prompt1[] = "Enter tribonacci(1): ";
    char prompt2[] = "Enter tribonacci(2): ";
    char promptN[] = "Enter n: ";
    /// okay the end output is different.
    char result[] = "tribonacci(%d) = %d";
    int the_end;
    int iterations = 0;

    /// input
    int input0 = getprompt(prompt0);
    int input1 = getprompt(prompt1);
    int input2 = getprompt(prompt2);
    int inputN = getprompt(promptN);

    /// work
    /* We actually just have to know the iteration and what the thing is
     So a queue would actually be the best data structure to make in this while loop
     with it being 0-1-2 then 1-2-3 then 2-3-4 and just pick the next thing off the
     queue. But that's too hard to do, so we are actually going to change the first thing.
     
     Bad explanation really, but if we choose the first box when we hit N and move it to the last
     of the three when we don't, we move the box in a pattern where picking the first box when we
     hit N makes sense. Of course, we move the box and also add the numbers while moving it.*/
    while(1)
    {
        // get out if the iterations are same as the n prompted.
        if (inputN == iterations)
        {
            if (inputN % 3 == 0) {the_end = input0;break;}
            if (inputN % 3 == 1) {the_end = input1;break;};
            /* last choice */the_end = input2;break;
        }
        if (iterations % 3 == 0) {input0 = input0 + input1 + input2; iterations += 1; continue;}
        if (iterations % 3 == 1) {input1 = input0 + input1 + input2; iterations += 1; continue;};
        /* last choice for update */input2 = input0 + input1 + input2; iterations += 1; continue;
    }
    /// output
    printf(result,inputN,the_end);
}